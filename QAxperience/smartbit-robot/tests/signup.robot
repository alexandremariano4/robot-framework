*** Settings ***
Documentation    Cenário de testes de pré-cadastro de clientes

Library    FakerLibrary    locale=pt_BR

Resource    ../resources/Base.resource
Resource    ../resources/pages/Welcome.resource


Test Setup        Start Session
Test Teardown     Take Screenshot


*** Test Cases ***
Deve iniciar o cadastro do cliente
    [Tags]    smoke
    ${account}    Create Dictionary
    ...    name=Alexandre Teste
    ...    email=teste@gmail.com
    ...    cpf=48637901042

    Delete Account By Email    ${account}[email]
    Submit Signup form    ${account}
    Verify welcome message

Tentativa de pré-cadastro
    [Template]    Attempt Signup    
    ${EMPTY}           teste@gmail.com     75835688032        Por favor informe o seu nome completo
    Alexandre Teste    ${EMPTY}            75835688032        Por favor, informe o seu melhor e-mail
    Alexandre Teste    teste@gmail.com     ${EMPTY}           Por favor, informe o seu CPF
    Alexandre Teste    teste*gmail.com     75835688032        Oops! O email informado é inválido 
    Alexandre Teste    teste&gmail.com     75835688032        Oops! O email informado é inválido 
    Alexandre Teste    www.teste.com.br    75835688032        Oops! O email informado é inválido 
    Alexandre Teste    DSAGUYDASY13S^&@    75835688032        Oops! O email informado é inválido 
    Alexandre Teste    teste@gmail.com     758356880321654    Oops! O CPF informado é inválido 
    Alexandre Teste    teste@gmail.com     75835688011        Oops! O CPF informado é inválido 
    Alexandre Teste    teste@gmail.com     758356880          Oops! O CPF informado é inválido 
    Alexandre Teste    teste@gmail.com     758356880as        Oops! O CPF informado é inválido 
    Alexandre Teste    teste@gmail.com     dasdasdsada        Oops! O CPF informado é inválido 

*** Keywords ***
Attempt Signup
    [Arguments]    
    ...    ${name}
    ...    ${email}
    ...    ${cpf}
    ...    ${output_message}
    
    ${account}    Create Dictionary
    ...    name=${name}
    ...    email=${email}
    ...    cpf=${cpf}

    Submit Signup form    ${account}
    Notice should be      ${output_message}