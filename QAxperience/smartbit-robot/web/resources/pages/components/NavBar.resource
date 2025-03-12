*** Settings ***
Documentation    Ações e elementos da barra de navegação superior

Library    Browser

*** Keywords ***
Go to Memberships
    Click    css=a[href="/memberships"]
    Wait For Elements State    css=h1 >> text=Matrículas
    ...    visible
    ...    5

User is logged in 
    [Arguments]    ${email}

    ${element}    Set Variable    css=span.logged-user 
    Wait For Elements State     ${element}    visible    5
    Get Text                    ${element}    equal    ${email}  