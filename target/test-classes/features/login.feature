#language:pt
@login
Funcionalidade: Realizar Login
  Testes da API de login

  @loginSucesso @regressivo
  Cenario: Realizar login com sucesso
    Dado que tenha um payload valido da API de Login
    Quando envio uma requisicao do tipo POST em login
    E armazeno o token que recebo do reponse de Login


  @loginInvalido @regressivo
  Esquema do Cenario: Realizar Login com <cenario>
    Dado que tenha um payload da API de Login com as seguintes informacoes
      | email | <email> |
      | senha | <senha> |
    Quando envio uma requisicao do tipo POST em login
    Entao valido que recebo status 400 no response

    @loginUsuarioInvalido
    Exemplos:
      | cenario          | email              | senha    |
      | usuario invalido | invalido@email.com | 123456   |
    @loginSenhaInvalida
    Exemplos:
      | cenario          | email              | senha    |
      | senha invalida   | aluno@email.com    | invalido |