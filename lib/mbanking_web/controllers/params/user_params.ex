defmodule MbankingWeb.Api.Params.UserParams do
  @moduledoc false

  use Params.Schema, %{
    birth_date: :date,
    city: :string,
    country: :string,
    status: :string,
    cpf: :string,
    email: :string,
    gender: :string,
    name: :string,
    referral_code: :string,
    state: :string
  }

  import Ecto.Changeset

  def child(ch, params) do
    ch
    |> cast(params, [
      :birth_date,
      :city,
      :country,
      :cpf,
      :email,
      :gender,
      :name,
      :referral_code,
      :state
    ])
    |> validate_required(:cpf)
    |> validate_inclusion(:gender, ["male", "female"])
    |> validate_format(:email, ~r/@/)
    |> validate_cpf_is_valid()
  end

  defp validate_cpf_is_valid(changeset) do
    cpf_value = %Cpf{number: get_field(changeset, :cpf)}

    if Brcpfcnpj.cpf_valid?(cpf_value) do
      changeset
    else
      add_error(changeset, :cpf, "CPF deve ter 11 caracteress. Siga o formato XXXXXXXXXXX")
    end
  end
end
