#language:pt
@produtos
Funcionalidade: Gerenciamento de Produtos

  Contexto: Login como administrador
    Dado que faça o login com uma conta de administrador

  @criar-produto
  Cenario: Criar um novo produto com dados válidos
    E que eu tenho os seguintes dados do produto
      | nome      | Mouse Gamer RGB        |
      | preco     | 150                    |
      | descricao | Mouse       |
      | quantidade| 50                     |
    Quando envio uma requisição do tipo POST em produtos com autorização
    Então valido que recebo status 201 no response
    E a resposta deve conter a mensagem "Cadastro realizado com sucesso"
    E armazeno o ID do produto criado

  @criar-produto-nome-existente
  Cenario: Tentar criar produto com nome já existente
    Dado que eu tenho os seguintes dados do produto
      | nome      | Mouse Gamer RGB        |
      | preco     | 150                    |
      | descricao | Mouse para jogos       |
      | quantidade| 50                     |
    Quando envio uma requisição do tipo POST em produtos com autorização
    E eu tenho os seguintes dados do segundo produto
      | nome      | Mouse Gamer RGB        |
      | preco     | 200                    |
      | descricao | Outro mouse            |
      | quantidade| 30                     |
    Quando envio uma requisição do tipo POST para o segundo produto com autorização
    Então valido que recebo status 400 no response
    E a resposta deve conter a mensagem "Já existe produto com esse nome"

  @criar-produto-sem-token
  Cenario: Tentar criar produto sem token de autorização
    Dado que eu tenho os seguintes dados do produto
      | nome      | Mouse Gamer RGB        |
      | preco     | 150                    |
      | descricao | Mouse para jogos       |
      | quantidade| 50                     |
    Quando envio uma requisição do tipo POST em produtos sem autorização
    Então valido que recebo status 401 no response
    E a resposta deve conter a mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

  @buscar-produto-por-id
  Cenario: Buscar produto por ID existente
    Dado que eu tenho os seguintes dados do produto
      | nome      | Mouse Gamer RGB        |
      | preco     | 150                    |
      | descricao | Mouse para jogos       |
      | quantidade| 50                     |
    Quando envio uma requisição do tipo POST em produtos com autorização
    E armazeno o ID do produto criado
    Quando envio uma requisição do tipo GET em produtos por ID
    Então valido que recebo status 200 no response
    E valido que no campo "nome" possui o valor "Mouse Gamer RGB"
    E valido que no campo "preco" possui o valor 150
    E valido que no campo "descricao" possui o valor "Mouse para jogos"
    E valido que no campo "quantidade" possui o valor 50

  @buscar-produto-inexistente
  Cenario: Buscar produto por ID inexistente
    Quando envio uma requisição do tipo GET em produtos com ID "idInexistente123"
    Então valido que recebo status 400 no response
    E a resposta deve conter a mensagem "Produto não encontrado"

  @editar-produto
  Cenario: Editar produto existente
    Dado que eu tenho os seguintes dados do produto
      | nome      | Mouse Gamer RGB        |
      | preco     | 150                    |
      | descricao | Mouse para jogos       |
      | quantidade| 50                     |
    Quando envio uma requisição do tipo POST em produtos com autorização
    E armazeno o ID do produto criado
    E eu altero os dados do produto para
      | nome      | Mouse Gamer RGB Pro    |
      | preco     | 200                    |
      | descricao | Mouse profissional     |
      | quantidade| 30                     |
    Quando envio uma requisição do tipo PUT em produtos por ID com autorização
    Então valido que recebo status 200 no response
    E a resposta deve conter a mensagem "Registro alterado com sucesso"

  @editar-produto-sem-token
  Cenario: Tentar editar produto sem token de autorização
    Dado que eu tenho os seguintes dados do produto
      | nome      | Mouse Gamer RGB        |
      | preco     | 150                    |
      | descricao | Mouse para jogos       |
      | quantidade| 50                     |
    Quando envio uma requisição do tipo POST em produtos com autorização
    E armazeno o ID do produto criado
    E eu altero os dados do produto para
      | nome      | Mouse Gamer RGB Pro    |
      | preco     | 200                    |
      | descricao | Mouse profissional     |
      | quantidade| 30                     |
    Quando envio uma requisição do tipo PUT em produtos por ID sem autorização
    Então valido que recebo status 401 no response
    E a resposta deve conter a mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

  @deletar-produto
  Cenario: Deletar produto existente
    Dado que eu tenho os seguintes dados do produto
      | nome      | Mouse Gamer RGB        |
      | preco     | 150                    |
      | descricao | Mouse para jogos       |
      | quantidade| 50                     |
    Quando envio uma requisição do tipo POST em produtos com autorização
    E armazeno o ID do produto criado
    Quando envio uma requisição do tipo DELETE em produtos por ID com autorização
    Então valido que recebo status 200 no response
    E a resposta deve conter a mensagem "Registro excluído com sucesso"

  @deletar-produto-inexistente
  Cenario: Deletar produto inexistente
    Quando envio uma requisição do tipo DELETE em produtos com ID "idInexistente123" com autorização
    Então valido que recebo status 200 no response
    E a resposta deve conter a mensagem "Nenhum registro excluído"

  @deletar-produto-sem-token
  Cenario: Tentar deletar produto sem token de autorização
    Dado que eu tenho os seguintes dados do produto
      | nome      | Mouse Gamer RGB        |
      | preco     | 150                    |
      | descricao | Mouse      |
      | quantidade| 50                     |
    Quando envio uma requisição do tipo POST em produtos com autorização
    E armazeno o ID do produto criado
    Quando envio uma requisição do tipo DELETE em produtos por ID sem autorização
    Então valido que recebo status 401 no response
    E a resposta deve conter a mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

  @listar-produtos
  Cenario: Listar todos os produtos
    Dado que não há mais nenhum produto cadastrado
    Dado que eu tenho os seguintes dados do produto
      | nome      | Mouse Gamer RGB        |
      | preco     | 150                    |
      | descricao | Mouse para jogos       |
      | quantidade| 50                     |
    Quando envio uma requisição do tipo POST em produtos com autorização
    E eu tenho os seguintes dados do segundo produto
      | nome      | Teclado Mecânico       |
      | preco     | 300                    |
      | descricao | Teclado para jogos     |
      | quantidade| 25                     |
    Quando envio uma requisição do tipo POST para o segundo produto com autorização
    Quando envio uma requisição do tipo GET em produtos
    Então valido que recebo status 200 no response
    E valido que no campo "quantidade" possui o valor 2

  @listar-produtos-vazio
  Cenario: Listar produtos quando não há nenhum cadastrado
    Dado que não há mais nenhum produto cadastrado
    Quando envio uma requisição do tipo GET em produtos
    Então valido que recebo status 200 no response
    E valido que no campo "quantidade" possui o valor 0
    E valido que recebo uma lista vazia no response