*** Settings ***
Documentation    Suíte de testes de adesões de planos

Resource    ../resources/Base.resource
Resource    ../resources/pages/components/Modal.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder realizar uma nova adesão
    [Tags]    membership
    
    ${data}    Get Json fixture    memberships    create


    Delete Account By Email    ${data}[account][email]
    Insert Account             ${data}[account]

    SignIn admin
    Go to Memberships
    Create new membership    ${data}  
    Toast should be    Matrícula cadastrada com sucesso.

Não deve realizar adesão duplicada
    [Tags]    dupMembership

    ${data}    Get Json fixture    memberships    duplicate

    Insert Membership    ${data}

    SignIn admin
    Go to Memberships
    Create new membership    ${data}  
    Toast should be    O usuário já possui matrícula.

Deve buscar por nome
    [Tags]    search

    ${data}    Get Json fixture    memberships    search

    Delete Account By Email    emily@hotmail.com
    Insert Membership    ${data}

    SignIn admin
    Go to Memberships
    
    Search by name            ${data}[account][name]
    Should filter by name     ${data}[account][name]

    Delete Account By Email    ${data}[account][email]

Deve excluir uma matrícula
    [Tags]    remove
    ${data}    Get Json fixture    memberships    remove

    Insert Membership    ${data}

    SignIn admin
    Go to Memberships
    Request removal    ${data}[account][name]
    Confirm removal
    Membership should not be visible    ${data}[account][name]
