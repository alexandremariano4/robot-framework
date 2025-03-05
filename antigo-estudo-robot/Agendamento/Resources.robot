*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    FakerLibrary    locale=pt_BR
Library    Dialogs

*** Variables ***

${NAVEGADOR}            chrome
${URL}                  http://dev.agendamento.sebraemg.com.br/#!/login
${USUARIO}              patriciam
${SENHA}                Sebr@e329dev
${COD_PRODUTO}          "237005"
${CIDADE}               Belo Horizonte
${UNIDADE_NEGOCIO}      202
${CENTRO_CUSTO}         5002018

*** Keywords ***
Abrir navegador
    Open Browser  browser=${NAVEGADOR}
    Maximize Browser Window
Fechar navegador
    Capture Page Screenshot
    Close Browser
Acessar agendamento e criação de evento
    Go To    url=${URL}
    Wait Until Element Is Visible    id:CodUsuario
    Input Text                       id:CodUsuario                                                            ${USUARIO}
    Input Text                       id:Senha                                                                 ${SENHA}
    Wait Until Element Is Enabled    name:validar
    Click Button                     name:validar
    Sleep                            5s
    Wait Until Element Is Visible    //span[@class='md-title ng-binding ng-scope'][contains(.,'Agendamentos')]
    Mouse Down                       (//span[@class='ng-binding'][contains(.,'Produtos')])[1]
    Mouse Up                         (//span[@class='ng-binding'][contains(.,'Produtos')])[1]
    Sleep                            5s
    Wait Until Element Is Visible    //span[@class='md-title ng-binding ng-scope'][contains(.,'Produtos')]
    Input Text                       //input[contains(@type,'search')]                                        ${COD_PRODUTO}
    Sleep                            5s
    Wait Until Element Is Visible    //div[contains(@class,'card ng-scope')]
    Sleep                            5s
    #Busca a quantidade de produtos e seleciona um produto aleatório
    ${QTD_PRODUTOS}=                 Selenium Library.Get Element Count                      (//div[@class='card-action center-align'][contains(.,'Agendar')])
    ${PRODUTO_ALEATORIO}             Random Int         min=1    max=${QTD_PRODUTOS}   
    Wait Until Element Is Enabled    (//div[@class='card-action center-align'][contains(.,'Agendar')])[${PRODUTO_ALEATORIO}]
    Click Element                    (//div[@class='card-action center-align'][contains(.,'Agendar')])[${PRODUTO_ALEATORIO}] 
    Sleep    2s
    ${STATUS}  Run Keyword And Return Status  Wait Until Element Is Enabled   //button[contains(@ng-click,'agendar(agendarData)')]
  
    IF    ${STATUS} == True
        Click Element    //button[contains(@ng-click,'agendar(agendarData)')]
    END
    Sleep                            2s
    #Busca a quantidade de produtos e seleciona um produto aleatório
    #Se for evento com o modal de 'Preencher briefing com base em produto anterior'
   
    ${QTD_ELEMENTOS_EVENTO}=               selenium library.Get Element Count       ul>li:not([class='ng-hide'])>div[role=button]
    
    IF    ${QTD_ELEMENTOS_EVENTO} == 8 
        #NÃO TEM CONTRATAÇÃO
        Preencher informações de evento
    ELSE
        Preencher informações de evento não catalogado
    END
Preencher informações de evento
    #Como o produto será pago
    Wait Until Element Is Visible        //form[@name='briefingFormPagamento']
    Wait Until Element Is Enabled        cidade
    Input Text                           cidade                            ${CIDADE}
    Input Text                           Cod_unid_negoc                    ${UNIDADE_NEGOCIO}
    Sleep                                1s

    # //label[text()="Tipo de público"]//parent::div//parent::div//*[@aria-label="Público Aberto"]

    Input Text                           css:input[id='Cod_ccusto']            ${CENTRO_CUSTO}
    Wait Until Element Is Visible        //*[@placeholder="Selecione a unidade organizacional"]   
    Click Element                       //*[@placeholder="Selecione a unidade organizacional"]
    Wait Until Element Is Visible       //*[contains(text(),'Atendimento')]   
    Click Element                       //*[contains(text(),'Atendimento')]
    Sleep                               1s
    Click Element                       //*[@ng-click="focusLocacao = true"]
    Wait Until Element Is Visible       //label[text()="Deseja locação?*"]//parent::div//parent::div//*[@aria-label="Não"]
    Sleep                               1.5s
    Click Element                       //label[text()="Deseja locação?*"]//parent::div//parent::div//*[@aria-label="Não"]

    Sleep                                3s
    
    # Click Element                        Cod_ccusto
    # Press Keys            none           TAB+ENTER
    # Sleep                                0.5s
    # Press Keys            none           ARROW_DOWN+ARROW_DOWN+ENTER
    # Sleep                                1s
    # #Dados para realização do produto
             
    # Click Element                        Cod_ccusto
    # Press Keys            none           TAB+TAB
    # Sleep                                1s
    # Click Element                        name:UnidadeOperacional
    # Press Keys            none           Belo+ARROW_DOWN+ARROW_DOWN+ENTER
    # Input Text                           Local_reali    text=SEDE
    # Input Text                           Cep            text=30431285
    # Sleep                                2s
    # Click Element                        //div[@role='button'][contains(.,'Dados adicionais para realização')]
    
    #Dados adicionais para realização


    
Preencher informações de evento não catalogado
    
    Sleep                            4s

    