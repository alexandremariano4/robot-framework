*** Settings ***
Documentation    Teste geral focus
Resource         ResourcesOpenShift.robot
#Abre e fecha google chrome
Test Setup       Open chrome
Test Teardown    Close chrome


*** Test Cases ***

Test Case 01 - Acesso ao perfil usuário e empresa e altera dados
    [Documentation]    Teste tem o intuito de passar no sistema de forma geral para 
...                    validar as funcionalidades básicas estão de acordo
    [Tags]             login    cadastro 


    Abrir a LandingPage do Focus
    Exploração de Focus pré-login
    Clicar em "Comece agora"
    Preencher dados de login e logar
    Entrar no perfil do usuário e alterar os dados
    Alterar dados pessoais
    Alterar dados de empresa

Test Case 02 - Acesso a tela de lançar dados 
    [Documentation]    Teste para lançar e excluir dados na tela de lançar dados 
    [Tags]             lancar_dados


    Apagar campos da tela de lançar dados
    Lançar dados

    
Test case 03 - Acesso a tela de plano de ação    
    [Documentation]    Teste para excluir e adicionar plano de ação
    [Tags]             plano_de_ação
    Apagar campos da tela de plano de ação
    Lançar plano de ação
