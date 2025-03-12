*** Settings ***
Documentation    Ações e elementos do componente modal de exclusão

Library    Browser

*** Keywords ***
Confirm removal
    Click    css=button[class*=confirm]
