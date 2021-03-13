defmodule MbankingWeb.Api.UserView do
  use MbankingWeb, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, __MODULE__, "user.json")}
  end

  def render("message.json", %{user: user}) do
    if user.status == "pending" do
      %{
        message:
          "Conta criada com sucesso. A conta possui status pendente. Por favor atualize seus dados para finalizar o seu cadastro."
      }
    else
      %{
        message:
          "Conta criada com sucesso. A conta possui status completo. Você pode indicar novos usuários. Seu código de indicação é: #{
            user.referral_code}"
      }
    end
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, __MODULE__, "message.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      cpf: user.cpf,
      birth_date: user.birth_date,
      gender: user.gender,
      city: user.city,
      state: user.state,
      country: user.country,
      status: user.status,
      referral_code: user.referral_code
    }
  end
end
