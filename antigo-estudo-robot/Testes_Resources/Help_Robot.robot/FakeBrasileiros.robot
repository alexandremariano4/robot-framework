*** Settings ***
Documentation   Faker com dados brasileiros
Library         FakerLibrary    locale=pt_BR

*** Test Cases ***




Teste dados fakes BRASILEIROS
    ${CPF}=                  FakerLibrary.cpf
    ${CNPJ}=                 FakerLibrary.cnpj
    ${NOME}=                 FakerLibrary.name
    ${CIDADE}=               FakerLibrary.city
    ${CEP}=                  FakerLibrary.postcode
    ${ESTADO}=               FakerLibrary.state
    ${CARTAO_NUMERO}=        FakerLibrary.Credit Card Number               card_type=visa16
    ${CARTAO_DIGITO}=        FakerLibrary.Credit Card Security Code        card_type=visa16
    # 4 digitos no ano
    ${CARTAO_DATA}=          FakerLibrary.Credit Card Expire               date_format=%m/%Y
    # 2 digitos no ano
    ${CARTAO_DATA}=          FakerLibrary.Credit Card Expire               date_format=%m/%y

 

    