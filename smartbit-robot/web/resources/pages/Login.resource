*** Settings ***
Documentation    Ações e elementos da página de Login

Library    Browser

Variables    ../Env.py

*** Keywords ***
Go to login page
    Go To    ${BASE_URL}/login

Submit login form
    [Arguments]    ${email}    ${password}
    Fill Text    input[name=email]    ${email}
    Fill Text    input[name=password]    ${password}
    Click        css=button >> text=Entrar

