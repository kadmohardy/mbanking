defmodule Mbanking.Accounts.Services.CreateUserAccount do
  @moduledoc false
  alias Mbanking.Accounts.Repositories.AccountRepository
  alias Mbanking.Accounts.Entities.User
  require Logger
  @params_length 8
  def execute(user_params) do
    is_all_params = user_params
                  |> validate_all_params()

    create_user_account(user_params, is_all_params)
  end

  defp validate_all_params(params) do
    params
    |> Map.take(["birth_date", "city", "state", "country", "cpf", "email", "gender", "name"])
    |> Map.values()
    |> Enum.reject(&is_nil/1)
    |> Enum.count() == @params_length
  end

  defp parse_to_cipher_params(params) do
    params
    |> Map.replace!("cpf", Cipher.cipher(params["cpf"]))
    |> Map.replace!("name", Cipher.cipher(params["name"]))
    |> Map.replace!("email", Cipher.cipher(params["email"]))
  end

  defp create_user_account(params, true) do
    update_params = params
    |> parse_to_cipher_params()
    |> Map.put_new("status", "completo")
    |> Map.put_new("referral_code", "12345678")

    AccountRepository.create_user(update_params)
  end

  defp create_user_account(params, false) do
    update_params = params
    |> parse_to_cipher_params()
    |> Map.put_new("status", "pendente")

    AccountRepository.create_user(update_params)
  end

end
