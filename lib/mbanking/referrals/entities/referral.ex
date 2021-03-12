defmodule Mbanking.Referrals.Entities.Referral do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias Mbanking.Accounts.Entities.User

  schema "referrals" do
    belongs_to :user, User, foreign_key: :user_id, type: :binary_id
    belongs_to :referral_user, User, foreign_key: :user_referral_id, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(referral, attrs) do
    referral
    |> cast(attrs, [:user_id, :user_referral_id])
    |> validate_required([:user_id, :user_referral_id])
    |> foreign_key_constraint(:user_referral_id)
  end
end
