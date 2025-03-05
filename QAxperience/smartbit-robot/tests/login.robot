*** Settings ***
Documentation    Cenários de teste do Login SAC

Library    Browser
Resource   ../resources/Base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve logar como Gestor de Academia
    Go to login page