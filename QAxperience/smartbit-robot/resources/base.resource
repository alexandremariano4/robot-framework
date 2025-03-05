*** Settings ***
Documentation    Arquivo principal do projeto robot

Library    Browser
Library    libs/Account.py

Resource    pages/Landing.resource
Resource    pages/Welcome.resource
Resource    pages/Login.resource

*** Keywords ***
Start Session
    New Browser    browser=chromium    headless=False
    New Page    http://localhost:3000