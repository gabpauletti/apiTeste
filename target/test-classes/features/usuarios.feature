#language:pt
@all
Funcionalidade: Gerenciamento de Usuários

  @criar
  Cenario: Criar um novo usuário administrador com dados válidos

    Dado que eu tenho os seguintes dados do usuário
      | nome          | Gabriel                |
      | email         | gabriel@qa.com   |
      | password      | 12345                  |
      | administrador | true                   |
    Quando envio uma requisição do tipo POST em usuarios
    Então valido que recebo status 201 no response
    E a resposta deve conter a mensagem "Cadastro realizado com sucesso"
    E armazeno o ID do usuário criado

  @buscar
  Cenario: Buscar usuário por ID
    Dado que eu tenho os seguintes dados do usuário
      | nome          | Pedro               |
      | email         | pedro@qa.com   |
      | password      | 12345                  |
      | administrador | true                   |
    Quando envio uma requisição do tipo POST em usuarios
    E armazeno o ID do usuário criado
    Quando envio uma requisição do tipo GET em usuarios por ID
    Então valido que recebo status 200 no response
    E valido que no campo "nome" possui o valor "Pedro"
    E valido que no campo "email" possui o valor "pedro@qa.com"
    E valido que no campo "administrador" possui o valor "true"

  @buscar-inexistente
  Cenario: Buscar usuário por ID inexistente
    Quando envio uma requisição do tipo GET em usuarios com ID "idInexistente123"
    Então valido que recebo status 400 no response
    E a resposta deve conter a mensagem "Usuário não encontrado"

  @editar
  Cenario: Editar usuário existente
    Dado que eu tenho os seguintes dados do usuário
      | nome          | Rafael               |
      | email         | Rafael@qa.com   |
      | password      | 12345                  |
      | administrador | true                   |
    Quando envio uma requisição do tipo POST em usuarios
    E armazeno o ID do usuário criado
    E eu altero os dados do usuário para
      | nome          | Rafael Editado        |
      | email         | rafaeleditado@qa.com  |
      | password      | 54321                  |
      | administrador | false                  |
    Quando envio uma requisição do tipo PUT em usuarios por ID
    Então valido que recebo status 200 no response
    E a resposta deve conter a mensagem "Registro alterado com sucesso"

  @editar-email-existente
  Cenario: Tentar editar usuário com email já utilizado
    Dado que eu tenho os seguintes dados do usuário
      | nome          | Usuario1               |
      | email         | usuario1@qa.com        |
      | password      | 12345                  |
      | administrador | true                   |
    Quando envio uma requisição do tipo POST em usuarios
    E eu tenho os seguintes dados do segundo usuário
      | nome          | Usuario2               |
      | email         | usuario2@qa.com        |
      | password      | 12345                  |
      | administrador | false                  |
    Quando envio uma requisição do tipo POST para o segundo usuário
    E armazeno o ID do segundo usuário criado
    E eu altero os dados do usuário para
      | nome          | Usuario2 Editado       |
      | email         | usuario1@qa.com        |
      | password      | 54321                  |
      | administrador | false                  |
    Quando envio uma requisição do tipo PUT em usuarios por ID
    Então valido que recebo status 400 no response
    E a resposta deve conter a mensagem "Este email já está sendo usado"

  @deletar
  Cenario: Deletar usuário existente
    Dado que eu tenho os seguintes dados do usuário
      | nome          | Jose                |
      | email         | Jose@qa.com   |
      | password      | 12345                  |
      | administrador | true                   |
    Quando envio uma requisição do tipo POST em usuarios
    E armazeno o ID do usuário criado
    Quando envio uma requisição do tipo DELETE em usuarios por ID
    Então valido que recebo status 200 no response
    E a resposta deve conter a mensagem "Registro excluído com sucesso"

  @deletar-inexistente
  Cenario: Deletar usuário inexistente
    Quando envio uma requisição do tipo DELETE em usuarios com ID "idInexistente123"
    Então valido que recebo status 200 no response
    E a resposta deve conter a mensagem "Nenhum registro excluído"

  @listar-todos
  Cenario: Listar todos os usuários
    Dado que não há nenhum usuario cadastrado
    E que eu tenho os seguintes dados do usuário
      | nome          | Gabriel1               |
      | email         | gabriel1@qa.com        |
      | password      | 12345                  |
      | administrador | true                   |
    Quando envio uma requisição do tipo POST em usuarios
    E eu tenho os seguintes dados do segundo usuário
      | nome          | Gabriel2               |
      | email         | gabriel2@qa.com        |
      | password      | 54321                  |
      | administrador | false                  |
    Quando envio uma requisição do tipo POST para o segundo usuário
    Quando envio uma requisição do tipo GET em usuarios
    Então valido que recebo status 200 no response
