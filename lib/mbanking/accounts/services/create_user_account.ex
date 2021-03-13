defmodule Mbanking.Accounts.Services.CreateUserAccount do
  @moduledoc false
  alias Mbanking.Accounts.Repositories.AccountRepository
  alias Mbanking.Accounts.Services.Shared.ParamsParse

  def execute(user_params) do
    referral_code = user_params["referral_code"]
    cpf = user_params["cpf"]

    user = AccountRepository.get_user_by_cpf(Cipher.encrypt(cpf))

    cond do
      user && user.status == "completed" ->
        {:error, "Já existe uma conta com status completo refente a esse CPF "}

      # 1. Cadastra usuario nao cadastrado
      referral_code == nil ->
        create_user_account(user_params)

      # 2. Atualiza uma conta ja cadastrada usario pode indicacao
      true ->
        case AccountRepository.get_user_by_referral(referral_code) do
          nil ->
            {:error, "Código de indicação inválido"}

          referral_user ->
            user_params
            |> Map.delete("referral_code")
            |> create_user_account(referral_user)
        end
    end
  end

  defp create_user_account(params) do
    params
    |> ParamsParse.parse_params()
    |> AccountRepository.create_user()
  end

  defp create_user_account(params, referral_user) do
    params
    |> ParamsParse.parse_params()
    |> AccountRepository.create_user_with_referral(referral_user)
  end
end
