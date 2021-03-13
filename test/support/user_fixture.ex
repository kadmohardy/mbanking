defmodule Mbanking.UserFixture do
  @moduledoc false
  alias Mbanking.Accounts.Repositories.AccountRepository

  def referral_user,
    do: %{
      birth_date: ~D[2010-04-17],
      city: "some city",
      country: "some country",
      cpf: "2580644056",
      email: "email@email",
      gender: "male",
      referral_code: "23412545",
      name: "some name",
      state: "some state",
      status: "completed"
    }

    def valid_user,
    do: %{
      birth_date: ~D[2010-04-17],
      city: "some city",
      country: "some country",
      cpf: "11310402019",
      email: "email@email",
      gender: "male",
      name: "some name",
      state: "some state",
      status: "completed"
    }

  def valid_user_pending_api,
    do: %{
      birth_date: ~D[2010-04-17],
      cpf: "11310402019",
      email: "email@email",
      gender: "male",
      name: "some name",
      status: "pending"
    }

  def valid_user_complete_api,
    do: %{
      birth_date: ~D[2010-04-17],
      city: "some city",
      country: "some country",
      cpf: "11310402019",
      email: "email@email",
      gender: "male",
      name: "some name",
      state: "some state",
    }

  def valid_user_with_referral_code,
    do: %{
      birth_date: ~D[2010-04-17],
      city: "some city",
      country: "some country",
      cpf: "11310402019",
      email: "email@email",
      gender: "male",
      name: "some name",
      state: "some state",
      status: "completed",
      referral_code: "23412545"
    }


  def update_user,
    do: %{
      birth_date: ~D[2010-04-17],
      city: "Fortaleza",
      country: "Brazil",
      cpf: "11310402019",
      email: "email@email",
      gender: "male",
      name: "some name",
      state: "some state",
      status: "completed"
    }

  def invalid_user, do: %{
    birth_date: nil,
    city: nil,
    country: nil,
    cpf: nil,
    email: nil,
    gender: nil,
    name: nil,
    referral_code: nil,
    state: nil,
    status: nil
  }

  def create_user do
    {:ok, user} =
      valid_user()
      |> AccountRepository.create_user()

    user
  end

  def create_referral_user do
    {:ok, referral_user} =
      referral_user()
      |> AccountRepository.create_user()

    referral_user
  end
end
