*** Settings ***
Documentation    Arquivo principal do projeto de testes automatizados para Mobile

Library    AppiumLibrary
Library    JSONLibrary
Library    ../../libs/Database.py


Resource    ../../services/Service.resource

Resource    ./actions/account.resource
Resource    ./actions/mybody.resource
Resource    ./actions/login.resource
Resource    ./actions/components/popup.resource
Resource    ./actions/components/menu.resource


*** Keywords ***

Start Session
    
    Open Application    http://localhost:4723    
    ...    platformName=Android
    ...    automationName=UIAutomator2
    ...    deviceName=Appium
    ...    app=${EXECDIR}\\app\\qax-smartbit.apk
    ...    autoGrantPermissions=true
    
    Wait Until Page Contains    IP da API    30

Finish Session
    
    Capture Page Screenshot
    Close Application

Get Json fixture
    [Arguments]    ${scenario}
    ${data}    Load Json From File    
    ...    ${EXECDIR}/resources/fixtures/data.json
    ...    encoding=utf-8
    
    RETURN    ${data}[${scenario}]