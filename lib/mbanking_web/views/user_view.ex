defmodule MbankingWeb.UserView do
  use MbankingWeb, :view
  alias MbankingWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
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
      countrystatus: user.countrystatus,
      referral_code: user.referral_code
    }
  end
end
