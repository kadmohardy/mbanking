defmodule Mbanking.Accounts.Repositories.AccountRepository do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Mbanking.Repo

  alias Mbanking.Accounts.Entities.User
  alias Mbanking.Referrals.Entities.Referral

  def list_users do
    Repo.all(User)
  end

  def get_user(id), do: Repo.get(User, id)

  def get_user_by_cpf(cpf), do: Repo.get_by(User, cpf: cpf)

  def get_user_by_referral(referral_code), do: Repo.get_by(User, referral_code: referral_code)

  def create_user(attrs \\ %{}) do
    cpf = attrs["cpf"]

    case Repo.get_by(User, cpf: cpf) do
      # Post not found, we build one
      nil -> %User{}
      # Post exists, let's use it
      user -> user
    end
    |> User.changeset(attrs)
    |> Repo.insert_or_update()
  end

  def insert_or_update_referral(%User{} = user, %User{} = referral_user) do
    case Repo.get_by(Referral, user_id: user.id) do
      # Post not found, we build one
      nil -> %Referral{}
      # Post exists, let's use it
      referral -> referral
    end
    |> Referral.changeset(%{
      user_id: user.id,
      user_referral_id: referral_user.id
    })
    |> Repo.insert_or_update()

  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def create_user_with_referral(attrs \\ %{}, %User{} = referral_user) do
    Repo.transaction(fn ->
      with {:ok, user} <- create_user(attrs),
           {:ok, _referral} <- insert_or_update_referral(user, referral_user) do
        user
      else
        err -> err
      end
    end)
  end

  def update_user_with_referral(attrs \\ %{}, %User{} = user, %User{} = referral_user) do
    Repo.transaction(fn ->
      with {:ok, user} <- update_user(user, attrs),
           {:ok, _referral} <- insert_or_update_referral(user, referral_user) do
        user
      else
        err -> err
      end
    end)
  end
end
