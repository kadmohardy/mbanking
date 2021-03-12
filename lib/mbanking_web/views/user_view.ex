defmodule MbankingWeb.Api.UserView do
  use MbankingWeb, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, __MODULE__, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, __MODULE__, "user.json")}
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
