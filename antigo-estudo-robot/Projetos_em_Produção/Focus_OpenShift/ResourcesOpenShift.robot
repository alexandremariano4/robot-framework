*** Settings ***
Library     SeleniumLibrary
Library    XML 
Library    FakerLibrary 
Library    RequestsLibrary
*** Variables ***
${PERFIL_ICONE}              //div[contains(@class,'navbar-button')]
${MINHA_CONTA}               //div[@class='navbar-row'][contains(.,'Minha Conta')]
##
&{LOGIN_AMEI}                usuario=alexandre.lightbase@sebraemg.com.br        senha=123456                usuarioEmpresa=azulsebrae@hotmail.com       senhaEmpresa=123456
&{ALTERAÇÃO_PF}              nome=Robot Framework                               telefone=47984790524          sobrenome=Teste Automatico                  cpf=57085248475
&{ALTERAÇÃO_PJ}              nomeEmpresa=Automatic Test                         razaoSocial=BotFram
##
&{DADOS_COMERCIAIS}          dado1=500              dado2=600              dado3=700             
&{DADOS_FINANCEIROS}         dadof1=3000            dadof2=7600            dadof3=3450            dadof4=6314            dadof5=24579
&{DADOS_OP_TEC}              dadot1=150             dadot2=76              
&{DADOS_RH}                  dadorh1=64


*** Keywords ***

Open chrome
    Open Browser  browser=chrome
    Maximize Browser Window
Close chrome
    Capture Page Screenshot
    Close Browser
Abrir a LandingPage do Focus
    Go To    url=https://focusopenshift.sebraemg.com.br/#/
Exploração de Focus pré-login
    Sleep                            time_=2s
    Press Keys            none       PAGE_DOWN+PAGE_DOWN+PAGE_DOWN
    Sleep                            time_=2s
    Click Element                    locator=//a[contains(.,'Conteúdos')]
    Sleep                            time_=2s
    Wait Until Element Is Visible    locator=//p[@class='textoBanner'][contains(.,'ANALISE SEU NEGÓCIO, SE COMPARE COM OUTRAS EMPRESAS E CRESÇA DE FORMA CONSISTENTE !')]
    Press Keys            none       TAB+TAB+ENTER
    Sleep                            time_=2s
    Click Element                    locator=//a[contains(.,'Início')]

Clicar em "Comece agora"
    Sleep                            time_=2s
    Wait Until Element Is Visible    locator=//button[@type='button'][contains(.,'Comece agora')]
    Click Button                     locator=//button[@type='button'][contains(.,'Comece agora')]
    
    
Preencher dados de login e logar
    Wait Until Element Is Visible     locator=username
    Input Text                        locator=username    text=${LOGIN_AMEI.usuario}
    Input Password                    locator=password    password=${LOGIN_AMEI.senha}
    Click Button                      locator=kc-login
    Sleep                             time_=6s

Entrar no perfil do usuário e alterar os dados
    Wait Until Element Is Visible     locator=(//canvas[contains(@height,'200')])[1]
    Title Should Be                   title=Focus
    Abrir a empresa
    Sleep                             2
    Click Element                     locator=${PERFIL_ICONE}
    Click Element                     locator=${MINHA_CONTA}
    Wait Until Element Is Visible     locator=firstName
    Element Should Be Disabled        locator=floatingInput
    Sleep                             time_=2s
    Click Button                      locator=//button[@type='button'][contains(.,'Editar')]  
    Sleep                             time_=2s    
    Wait Until Element Is Enabled     locator=cpf  
    Click Element                     locator=lastName
    Press Keys                        none      CTRL+a+BACKSPACE
    Click Element                     locator=cpf
    Press Keys                        none      CTRL+a+BACKSPACE
    Click Element                     locator=floatingInput
    Press Keys                        none      CTRL+a+BACKSPACE

Alterar dados pessoais   
    Input Text                        locator=phone                                 text=${ALTERAÇÃO_PF.telefone}   
    Input Text                        locator=cpf                                   text=${ALTERAÇÃO_PF.cpf}   
    Input Text                        locator=floatingInput                         text=${ALTERAÇÃO_PF.nome}   
    Input Text                        locator=lastName                              text=${ALTERAÇÃO_PF.sobrenome}   
    #Checkbox
    Select Checkbox                   locator=receive_feed
    Sleep                             time_=2s
    Click Button                      locator=//button[@type='submit'][contains(.,'Salvar')]
    Sleep                             time_=2s
Alterar dados de empresa
    Go To    url=https://focusopenshift.sebraemg.com.br/#/app/minha-empresa
    Wait Until Element Is Visible    locator=nomeFantasia
    Element Should Be Disabled       locator=nomeFantasia
    Click Button                     locator=//button[@type='button'][contains(.,'Editar')]
    #Dado de nome fantasia
    Click Element                    locator=nomeFantasia
    Press Keys        none           CTRL+a+BACKSPACE
    Input Text                       locator=nomeFantasia    text=${ALTERAÇÃO_PJ.nomeEmpresa}  
    #Dado de Razão Social
    Click Element                    locator=razaoSocial
    Press Keys        none           CTRL+a+BACKSPACE
    Input Text                       locator=razaoSocial     text=${ALTERAÇÃO_PJ.razaoSocial}  
    #Alterar porte de empresa
    Mouse Down                       locator=porteEmpresa
    Press Keys        none           ARROW_DOWN+ENTER
    Click Element                    locator=//button[@type='submit'][contains(.,'Salvar')]
    Sleep                            time_=3s
    Fazer Logoff



Apagar dados LD
# Remover
    Sleep                                                    time_=3s
    Click Element                                            locator=//i[contains(@title,'Remover canal')]
    Sleep                                                    time_=1s
# Salvar
    Click Button                                             locator=//button[@type='submit'][contains(.,'Salvar')]
    Sleep                                                    time_=6s
Apagar campos da tela de lançar dados
    Go To                                                       url=https://focusopenshift.sebraemg.com.br/#/app/dados
    Sleep                                                       2s
    Preencher dados de login e logar
    Go To                                                       url=https://focusopenshift.sebraemg.com.br/#/app/dados
    Sleep                                                       time_=5s
    Abrir a empresa
    Wait Until Element Is Visible                               locator=//p[@class='sidebar-title'][contains(.,'Dashboard')]
    Wait Until Element Is Visible                               locator=(//input[contains(@type,'text')])
    Sleep    time_=10s 
   ${ITENS_PARA_EXCLUIR}=    SeleniumLibrary.Get Element Count                 locator=(//i[contains(@title,'Remover canal')])
    Log                       message=${ITENS_PARA_EXCLUIR}

    Repeat Keyword    ${ITENS_PARA_EXCLUIR}    Apagar dados LD  

Lançar dados
#Campo de Atendimentos realizados ou  orçamentos realizados  
    Sleep                           time_=2s
    Wait Until Element Is Enabled   locator=(//i[contains(@title,'Adicionar canal')])[1]
    Mouse Down                      locator=(//i[contains(@title,'Adicionar canal')])[1]
    Sleep                           time_=1s
    Mouse Up                        locator=(//i[contains(@title,'Adicionar canal')])[1]
    Sleep                           time_=4s
    Click Element                   locator=//div[contains(@class,'dados-input__input-container css-ackcql')]    
    Press Keys        none          Teste Robot+ENTER
    Sleep                           time_=3s
    Input Text                      locator=(//input[contains(@type,'text')])[4]          text=${DADOS_COMERCIAIS.dado1}
    Press Keys        none          ENTER
    Sleep                           time_=5s
#Campo de Número de Produtos Vendidos   
    Sleep                           time_=2s
    Wait Until Element Is Enabled   locator=(//i[contains(@title,'Adicionar canal')])[2]
    Mouse Down                      locator=(//i[contains(@title,'Adicionar canal')])[2]
    Sleep                           time_=1s
    Mouse Up                        locator=(//i[contains(@title,'Adicionar canal')])[2]
    Sleep                           time_=4s
    Click Element                   locator=(//div[contains(@class,'dados-input__input-container css-ackcql')])[2]    
    Press Keys         none         Teste Robotin 2+ENTER
    Sleep                           time_=3s
    Input Text                      locator=(//input[contains(@type,'text')])[7]           text=${DADOS_COMERCIAIS.dado2}
    Press Keys        none          ENTER
    Sleep                           time_=5s
#Campo de Número de Vendas ou Pedidos Realizados
    Sleep                           time_=2s
    Wait Until Element Is Enabled   locator=(//i[contains(@title,'Adicionar canal')])[3]
    Mouse Down                      locator=(//i[contains(@title,'Adicionar canal')])[3]
    Sleep                           time_=1s
    Mouse Up                        locator=(//i[contains(@title,'Adicionar canal')])[3]
    Sleep                           time_=4s
    Click Element                   locator=(//div[contains(@class,'dados-input__input-container css-ackcql')])[3]   
    Press Keys        none          Teste Bumblebee+ENTER
    Sleep                           time_=3s
    Input Text                      locator=(//input[contains(@type,'text')])[10]          text=${DADOS_COMERCIAIS.dado3}
    Press Keys        none          ENTER
    Sleep                           time_=10s
#Inserção de dados nos Dados Financeiros
 
    Clear Element Text              locator=campo-1180       
    Input Text                      locator=campo-1180  text=${DADOS_FINANCEIROS.dadof1}
    Clear Element Text              locator=campo-656
    Input Text                      locator=campo-657   text=${DADOS_FINANCEIROS.dadof2}
    Clear Element Text              locator=campo-656  
    Input Text                      locator=campo-656   text=${DADOS_FINANCEIROS.dadof3}
    Clear Element Text              locator=campo-1178 
    Input Text                      locator=campo-1178  text=${DADOS_FINANCEIROS.dadof4}
    Clear Element Text              locator=campo-663
    Input Text                      locator=campo-663   text=${DADOS_FINANCEIROS.dadof5}
#Repetição da inserção até correção do campo
    Clear Element Text              locator=campo-1180
    Input Text                      locator=campo-1180  text=${DADOS_FINANCEIROS.dadof1}
    Clear Element Text              locator=campo-657 
    Input Text                      locator=campo-657   text=${DADOS_FINANCEIROS.dadof2}
    Clear Element Text              locator=campo-656  
    Input Text                      locator=campo-656   text=${DADOS_FINANCEIROS.dadof3}
    Clear Element Text              locator=campo-1178 
    Input Text                      locator=campo-1178   text=${DADOS_FINANCEIROS.dadof4}
    Clear Element Text              locator=campo-663
    Input Text                      locator=campo-663    text=${DADOS_FINANCEIROS.dadof5}

#Inserção de dados nos Dados Operacionais e Técnicos
    Clear Element Text              locator=campo-1063
    Input Text                      locator=campo-1063    text=${DADOS_OP_TEC.dadot1}
    Clear Element Text              locator=campo-664
    Input Text                      locator=campo-664     text=${DADOS_OP_TEC.dadot2}
#Inserção de dados nos Recursos Humanos
    Clear Element Text              locator=campo-659
    Input Text                      locator=campo-659   text=${DADOS_RH.dadorh1}

    Click Button                     locator=//button[@type='submit'][contains(.,'Salvar')]
    Sleep                            time_=4s
    Fazer Logoff

Fazer Logoff
    Sleep                             time_=4s    
    Wait Until Element Is Enabled     locator=//i[contains(@class,'fas fa-sign-out-alt')]
    Mouse Down                        locator=//i[contains(@class,'fas fa-sign-out-alt')]
    Mouse Up                          locator=//i[contains(@class,'fas fa-sign-out-alt')]
    Sleep                             time_=2s
    Wait Until Element Is Visible     locator=//video[contains(@class,'homeVid')]

Apagar campos da tela de plano de ação
    Go To                                        url=https://focusopenshift.sebraemg.com.br/#/app/planos
    Sleep                             time_=2s
    Wait Until Element Is Visible     locator=username
    Input Text                        locator=username    text=${LOGIN_AMEI.usuarioEmpresa}
    Input Password                    locator=password    password=${LOGIN_AMEI.senhaEmpresa}
    Click Button                      locator=kc-login
    Wait Until Element Is Visible     locator=//button[@type='submit'][contains(.,'Cadastrar')]
    Click Button                      locator=//button[@type='submit'][contains(.,'Cadastrar')]
    Sleep                             time_=5s
    Go To                                        url=https://focusopenshift.sebraemg.com.br/#/app/planos
    Sleep                                        time_=3s
    Wait Until Element Is Visible                locator=//button[@type='button'][contains(.,'Adicionar planos')]
    Sleep                                        time_=3s
    ${PLANO_PARA_EXCLUIR}=     SeleniumLibrary.Get Element Count         locator=(//img[@src='/arrow-down-plano.svg'])
    Log    message=${PLANO_PARA_EXCLUIR}

    Repeat Keyword    ${PLANO_PARA_EXCLUIR}    Apagar dados PA   

Lançar plano de ação   
    Sleep                               time_=2s
    Click Button                        locator=//button[@type='button'][contains(.,'Adicionar planos')]
    Sleep                               time_=4s
    Input Text                          locator=nomeAcao                   text=Teste Alexandre
    Click Element                       locator=indicator
    Press Keys            none          ARROW_DOWN+ARROW_DOWN+ENTER
    Sleep                               time_=4s
    Click Element                       locator=progress
    Press Keys            none          ARROW_DOWN+ARROW_DOWN+ENTER
    Click Element                       locator=dataIni
    Press Keys            none          Fev+TAB+2022  
    Click Element                       locator=dataFim
    Press Keys            none          Mai+TAB+2022
    Sleep                               time_=4s
    Input Text                          locator=metaValues.0.meta            text=10
    Input Text                          locator=metaValues.1.meta            text=20
    Input Text                          locator=metaValues.2.meta            text=30
    Input Text                          locator=metaValues.3.meta            text=30
    Input Text                          locator=descAcao                     text=Teste Teste Teste
    Click Element                       locator=descAcao    
    Press Keys            none          TAB+ENTER
    Sleep                               time_=5s

Apagar dados PA
    Sleep                                time_=2s
    Click Element                        locator=(//img[@src='/trash.svg'])
    Sleep                                time_=1s
    Wait Until Element Is Visible        locator=//button[@type='button'][contains(.,'Sim, tenho certeza')]
    Click Button                         locator=//button[@type='button'][contains(.,'Sim, tenho certeza')]
    Sleep                                time_=3s

Abrir a empresa
    Sleep                            time_=5s
    Wait Until Element Is Enabled    locator=//div[@class=' css-ackcql'] 
    Click Element                    locator=//div[@class=' css-ackcql'] 
    Press Keys    none               ${ALTERAÇÃO_PJ.nomeEmpresa}+ENTER
    Sleep                            time_=5s        