*** Settings ***
Documentation          Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Suite Setup            Conectar a minha API

Resource    ResourceAPI.robot

*** Test Cases ***
Buscar a listagem de todos os livos (GET em todos os livros)
    Requisitar todos os livros
    Conferir o status Code    200
    Conferir o reason         OK
    Conferir se retorna uma lista com "200" livros

Buscar um livro específico (GET em um livro específico)
    Requisitar o livro "15"
    Conferir o status Code    200
    Conferir o reason         OK
    Conferir se retorna todos os dados do livro 15
Cadastrar um novo livro (POST)
    Cadastrar um novo livro

#Alterar um livro (PUT)
#Conferir se retorna todos os dados alterados do livro 150

# Deletar um livro (DELETE)
# Conferir se deleta o livro 200 (o response body deve ser vazio)