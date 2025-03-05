*** Settings ***
Documentation    Ações e elementos do componente Toast

Library    Browser

*** Keywords ***
Toast should be 
    [Arguments]    ${expected_text}
    
    ${element}    Set Variable    css=.Toastify__toast-body
    
        Wait For Elements State    ${element}
    ...    visible    5

    Get Text    ${element}
    ...    equal
    ...    ${expected_text}