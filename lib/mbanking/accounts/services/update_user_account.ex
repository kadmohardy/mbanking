defmodule Mbanking.Accounts.Services.UpdateUserAccount do
  @moduledoc false
  alias Mbanking.Accounts.Repositories.AccountRepository
  alias Mbanking.Accounts.Services.Shared.ParamsParse

  def execute(id, user_params) do
    referral_code = user_params["referral_code"]

    user = AccountRepository.get_user(id)

    cond do
      user == nil ->
        {:error, "Conta inexiste"}

      user && user.status == "completed" ->
        {:error, "Já existe uma conta com status completo refente a esse CPF "}

      referral_code == nil ->
        user_params
        |> update_user_account(user)

      true ->
        IO.puts "======================================================="
        case AccountRepository.get_user_by_referral(referral_code) do
          nil ->
            {:error, "Código de indicação inválido"}

          referral_user ->
            user_params
            |> Map.delete("referral_code")
            |> update_user_account(user, referral_user)
        end
    end
  end

  defp update_user_account(params, user) do
    params
    |> ParamsParse.parse_params()
    |> AccountRepository.update_user(user)
  end

  defp update_user_account(params, user, referral_user) do
    params
    |> ParamsParse.parse_params()
    |> AccountRepository.update_user_with_referral(user, referral_user)
  end
end
