defmodule MbankingWeb.Api.UserController do
  use MbankingWeb, :controller

  alias Mbanking.Accounts.Entities.User
  alias Mbanking.Accounts.Repositories.AccountRepository
  alias Mbanking.Accounts.Services.CreateUserAccount

  alias MbankingWeb.Api.Params.UserParams
  action_fallback MbankingWeb.FallbackController

  def index(conn, _params) do
    users = AccountRepository.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = UserParams.from(user_params, with: &UserParams.child/2)

    if changeset.valid? do
      with {:ok, user} <- CreateUserAccount.execute(user_params) do
        conn
        |> put_status(:created)
        |> render("show.json", user: user)
      end
    else
      conn
      |> put_status(:unprocessable_entity)
      |> put_view(MbankingWeb.ChangesetView)
      |> render("error.json", changeset: changeset)
    end
  end


  def update(conn, %{"id" => id, "user" => user_params}) do
    user = AccountRepository.get_user(id)

    with {:ok, %User{} = user} <- AccountRepository.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

end
