*** Settings ***
Documentation    Ações e elementos do componente popup

Library    AppiumLibrary

*** Keywords ***
Popuphave text
    [Arguments]    ${target}
    ${element}    Set Variable    xpath=//android.widget.TextView[@resource-id="android:id/message"]


    Wait Until Element Is Visible    ${element}    5
    Element Text Should Be           ${element}    ${target}