*** Settings ***
Documentation    Criação de eventos no agendamento
Resource         Resources.robot
Test Setup       Abrir navegador
Test Teardown    Fechar navegador


*** Test Cases ***

Caso de teste 01 - Acessar agendamento e criação de evento
    [Documentation]      Acesso ao agendamento para criação de evento
    [Tags]               criar_evento

    Acessar agendamento e criação de evento
    Preencher informações de evento não catalogado
    Preencher informações de evento