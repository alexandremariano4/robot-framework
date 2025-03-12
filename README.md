# Curso QAxperience

Para executar o ambiente de desenvolvimento, assegure que tenha executado o banco de dados postgres usando o docker, e depois de realizar o `npm install` tanto no diretório de API quanto no de WEB, execute o comando `npm run dev` para executar ambos.

Para popular o banco de dados, execute o arquivo [setup.sh](http://setup.sh) que está dentro do diretório da API, mas é necessário executá-lo em algum terminal linux

O ambiente será executado no endereço `localhost:3000` 

**Após rodando tudo corretamente, instale o Robot Framework em um ambiente virtual utilizando o comando**

`pip install robotframework`

Para conferir se o robot está funcionando corretamente além da instalação ter sido feita como esperado, crie um arquivo por exemplo “hello.robot” com as informações abaixo e execute `robot .\hello.robot` no terminal

```python
*** Settings ***
Documentation    Hello Robot

*** Test Cases ***
Deve mostrar mensagem de boas vindas
    Log    Hello Robot Framework    
```

Agora que validou a funcionalidade, faça a instalação da biblioteca browser do Playwrigth 

`pip install robotframework-browser`

E execute o Playwright para ser executado em ambiente Python usando o comando `rfbrowser init` no terminal

O código inicial deve ser parecido com este

```python
*** Settings ***
Documentation    Teste para verificar o Slogan no webapp
Library    Browser

*** Test Cases ***
Deve exibir o Slogan na Landing Page
    New Browser    browser=chromium    headless=False
    New Page    http://localhost:3000
    Get Text    css=.headline h2    equal    Sua Jornada Fitness Começa aqui!

    Sleep    5
```

A estrutura ideal para executar os testes em robot é a seguinte

![image.png](attachment:9035e17d-8700-4126-b4b0-d8e179077b18:image.png)

O diretório principal, com a pasta resources e tests, e a pasta logs sendo gerada via parâmetro ao executar o script do robot `robot -d ./logs .\tests\slogan.robot`

### Faker para geração de massa de teste (utilizando a lib existente)

`pip install robotframework-faker`

Após instalado, implemente no código da seguinte forma (´é necessário informar o locale para dados específicos do brasil)

```python
*** Settings ***
Documentation    Cenário de testes de pré-cadastro de clientes
Library    Browser
Library    FakerLibrary    locale=pt_BR

*** Test Cases ***
Deve iniciar o cadastro do cliente
    ${name}=     FakerLibrary.Name
    ${email}=     FakerLibrary.Email
    ${cpf}=     FakerLibrary.cpf

    Fill Text    id=name        ${name}
    Fill Text    id=email       ${email}
    Fill Text    id=document    ${cpf}

```

### Criando um arquivo resource e lib própria

utilize o comando `pip install faker` para instalar a biblioteca faker para o python para a criação da função

Para criar um arquivo “pai” onde as automações irão se centralizar, vá na pasta resources e crie um arquivo chamado “base.resources”, além de criar dentro da pasta resources, uma pasta chamada “libs” com um arquivo chamado account

![image.png](attachment:5a24be00-38bd-46fa-858e-1972695a3f9a:image.png)

No arquivo “signup.robot” , importe a base resource utilizando a seguinte instrução no código `*Resource*    ../resources/base.resource`

No arquivo base.resource, importe a library própria que foi criada 

```python
*** Settings ***
Documentation    Arquivo principal do projeto robot
Library    libs/account.py
```

E no arquivo [account.py](http://account.py) crie a função que irá gerar os accounts

```python
from faker import Faker
fake = Faker('pt_BR')

def get_fake_account():
    account = {
        'name': fake.name(),
        'email': fake.email(),
        'cpf': fake.ssn() #gerar cpf sem pontuação, com pontuação é "cpf"
    }
    return account
```

Para chamar a keyword (função) criada no account.py, apenas digite “Get Fake Account” no “signup.robot” e estará podendo utilizar dos recursos, na prática o código ficará similar a isso:

```python
    ${account}    Get Fake Account

    Fill Text    id=name        ${account}[name]
    Fill Text    id=email       ${account}[email]
    Fill Text    id=document    ${account}[cpf]
```

### Uso de tags para executar os scripts

Caso envie o comando `robot .\tests` no terminal, será executado todos os scripts dentro da pasta tests

`robot -d ./logs .\tests`  Para salvar os logs da execução dentro da pasta de logs

`robot -i required .\tests` Para executar somente os cenários que contenham a tag “required” 

### Como lidar com elementos flutuantes (que somem da tela caso clique em outro lugar da página)

Para lidar com esse comportamento, existe algumas opções, sendo uma delas pegar o HTML da página no momento que faz a interação, então por exemplo

```python
    Fill Text    css=input[aria-label=select_account]    Nome teste
    Sleep    2
    ${html}    Get Page Source
    Log    ${html}
```

Com isso, quando você verificar no log, poderá ver que está o HTML da página no momento que exibiu a opção no DOM.

Outra opção é ir na aba “Console” no devtools e colocar o código

`setTimeout(() => {debugger; }, 5000)`

- Explicação da função de settimeout + debuger
    
    ### **1. `setTimeout()`**
    
    O `setTimeout()` é uma função do JavaScript usada para agendar a execução de um código depois de um determinado tempo. Sua estrutura é:
    
    ```jsx
    javascript
    CopiarEditar
    setTimeout(função, tempoEmMilissegundos);
    
    ```
    
    - **`função`** → O que será executado depois do tempo definido.
    - **`tempoEmMilissegundos`** → Tempo de espera antes de executar a função (1000ms = 1 segundo).
    
    ---
    
    ### **2. Função de Callback `() => { debugger; }`**
    
    No código original, a função dentro do `setTimeout` é uma **arrow function** (função anônima).
    
    ```jsx
    javascript
    CopiarEditar
    () => { debugger; }
    
    ```
    
    Ela é equivalente a:
    
    ```jsx
    javascript
    CopiarEditar
    function() {
        debugger;
    }
    
    ```
    
    Dentro dessa função, temos o comando:
    
    - **`debugger;`** → Pausa a execução do JavaScript e abre o DevTools (se estiver aberto), permitindo inspecionar o código e os elementos da página.
    
    ---
    
    ### **3. Tempo de Espera (`5000`)**
    
    O segundo argumento do `setTimeout` define que a função será executada após **5000 milissegundos (5 segundos)**.
    
    Isso permite que elementos flutuantes, menus dropdown ou pop-ups apareçam antes de inspecioná-los no DevTools.
    
    ---
    
    ### **Código Explicado**
    
    ```jsx
    javascript
    CopiarEditar
    setTimeout(() => {
        debugger;  // Pausa o código após 5 segundos
    }, 5000);
    
    ```
    
    1. Aguarda **5 segundos**.
    2. Executa `debugger;`, pausando o JavaScript e permitindo inspeção.
    
    Se quiser testar no console do navegador, basta copiar e colar esse código, abrir o DevTools (F12) e aguardar 5 segundos.
    

E interagir com o elemento digitando o texto pretendido, e aguardar o navegador entrar em modo de debug, neste momento, você pode interagir e ter obter o elemento 

### Lidando com JSON em robot framework

É necessário instalar a `biblioteca robotframework-jsonlibrary` e você pode criar um arquivo json de Fixtures, por exemplo, dentro do diretório “resources” ficando como no exemplo abaixo:

```python
{
    "create":{
        "account":{
            "name":  "Usuário Teste",
            "email": "emailtest@gmail.com",
            "cpf":   "24507099080"
        },
        "plan": "Plano Black",
        "credit_card":{
            "number": "4242424242424242",
            "holder":"Usuário Teste",
            "month": "12",
            "year": "2030",
            "cvv":  "123"
        }
    }
}
```

Faça a importação no arquivo base.resource utilizando : `Library    JSONLibrary` e com o exemplo do código abaixo, carregue o arquivo json

O “scenario” é qual objeto de dados você vai utilizar, ou seja, para qual cenário, no exemplo aqui, seria para o “create”, caso tivessem outros, poderiam importar outros dados

```python
Get Json fixture
    [Arguments]    ${file_name}    ${scenario}
    ${data}    Load Json From File    
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8
    
    RETURN    ${data}[${scenario}]
```