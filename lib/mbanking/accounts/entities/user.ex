defmodule Mbanking.Accounts.Entities.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Mbanking.Referrals.Entities.Referral

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "users" do
    field :birth_date, :date
    field :city, :string
    field :country, :string
    field :status, :string
    field :cpf, :string
    field :email, :string
    field :gender, :string
    field :name, :string
    field :state, :string
    field :referral_code, :string

    has_many :referrals, Referral

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :email,
      :cpf,
      :birth_date,
      :gender,
      :city,
      :state,
      :country,
      :status,
      :referral_code
    ])
    |> validate_inclusion(:gender, ["male", "female"])
    |> validate_required(:cpf)
    |> unique_constraint(:cpf)
    |> unique_constraint(:email)
  end
end
