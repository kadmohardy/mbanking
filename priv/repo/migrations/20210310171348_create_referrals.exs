defmodule Mbanking.Repo.Migrations.CreateReferrals do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:referrals, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id,
          references(:users, on_delete: :nilify_all, on_update: :nilify_all, type: :uuid)

      add :user_referral_id,
          references(:users, on_delete: :nilify_all, on_update: :nilify_all, type: :uuid)

      timestamps()
    end

    create index(:referrals, [:user_referral_id])
    create index(:referrals, [:user_id])
  end
end
