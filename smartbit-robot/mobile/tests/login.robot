*** Settings ***
Documentation    Suíte de testes de login

Resource    ../resources/Base.resource

Test Setup        Start Session
Test Teardown     Finish Session

*** Test Cases ***
Deve logar com CPF e IP
    ${data}    Get Json fixture    create
    
    Insert Membership    ${data}

    SignIn with document    ${data}[account][cpf]
    User is logged in

Não deve logar com cpf não cadastrado
    SignIn with document      83422842470
    Popuphave text            Acesso não autorizado! Entre em contato com a central de atendimento

Não deve logar com cpf com digito inválido
    SignIn with document      00000014144
    Popuphave text            CPF inválido, tente novamente