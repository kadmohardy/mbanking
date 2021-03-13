# Mbanking

### 1. Configuração inicial do projeto
Foi criado um projeto "api only" utilizando o Phoenix. Inicialmente, foram realizadas as configurações iniciais para garantir a qualidade de código, que são:

* Configuração do Credo
* Configuração do Sobelow
* Configuração do Dialyzer

As ferramentas acima são essenciais para garantir um bom código elixir.

### 2. Configuração do CI/CD
Em um segundo momento, foi feita a configuração de CI/CD

* Configuração do Travis
* Configuração do CodeCov
* Configuração do Coveralls
* Criação do DockerFile e docker-compose

### 3. Funcionalidades
A api recebe requisições de usuários para realizar o cadastro de uma nova conta. Na aplicação temos basicamente dois contextos, Accounts e Referrals, o primeiro reflete as contas de usuário e o segundo as indicações. A tabela users armazena as contas cadastradas e referrals, as indicações.

### 4. Testes
O projeto possui uma cobertura de 94.7% de testes. Não foram realizados testes de carga.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
