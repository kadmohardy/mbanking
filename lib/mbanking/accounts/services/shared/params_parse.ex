defmodule Mbanking.Accounts.Services.Shared.ParamsParse do
  @moduledoc false
  alias Mbanking.Utils.Crypto
  alias Mbanking.Utils.Math

  @params_length 8
  @referral_code_length 8

  defp encrypt_params(params) do
    params
    |> Crypto.encrypt_map_item("cpf")
    |> Crypto.encrypt_map_item("email")
    |> Crypto.encrypt_map_item("name")
  end

  def parse_params(params) do
    parsed_params = params |> encrypt_params()

    if validate_all_params(parsed_params) do
      parsed_params
      |> Map.put_new("status", "completed")
      |> Map.put_new("referral_code", Math.generate_code(@referral_code_length))
    else
      parsed_params
      |> Map.put_new("status", "pending")
    end
  end

  defp validate_all_params(params) do
    params
    |> Map.take(["birth_date", "city", "state", "country", "cpf", "email", "gender", "name"])
    |> Map.values()
    |> Enum.reject(&is_nil/1)
    |> Enum.count() == @params_length
  end
end
