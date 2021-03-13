defmodule Mbanking.AccountsTest do
  @moduledoc false
  use Mbanking.DataCase

  alias Mbanking.Accounts.Repositories.AccountRepository
  alias Mbanking.UserFixture

  describe "users" do
    alias Mbanking.Accounts.Entities.User

    test "list_users/0 returns all users" do
      UserFixture.create_user()
      assert AccountRepository.list_users() |> Enum.count() == 1
    end

    test "get_user!/1 returns the user with given id" do
      user = UserFixture.create_user()
      response = AccountRepository.get_user(user.id)
      assert response.id == user.id
      assert response.city == user.city
      assert response.country == user.country
      assert response.state == user.state
      assert response.gender == user.gender
      assert response.email == user.email
      assert response.cpf == user.cpf
      assert response.birth_date == user.birth_date
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = AccountRepository.create_user(UserFixture.valid_user())
      assert user.birth_date == ~D[2010-04-17]
      assert user.city == "some city"
      assert user.country == "some country"
      assert user.cpf == "11310402019"
      assert user.email == "email@email"
      assert user.gender == "male"
      assert user.name == "some name"
      assert user.state == "some state"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AccountRepository.create_user(UserFixture.invalid_user())
    end

    test "update_user/2 with valid data updates the user" do
      user = UserFixture.create_user()

      assert {:ok, %User{} = user} = AccountRepository.update_user(UserFixture.update_user(), user)
      assert user.birth_date == ~D[2010-04-17]
      assert user.city == "Fortaleza"
      assert user.country == "Brazil"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = UserFixture.create_user()
      assert {:error, %Ecto.Changeset{}} = AccountRepository.update_user(UserFixture.invalid_user(), user)
    end

  end
end
