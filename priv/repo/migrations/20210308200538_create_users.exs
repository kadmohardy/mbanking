defmodule Mbanking.Repo.Migrations.CreateUsers do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :email, :string
      add :cpf, :string
      add :birth_date, :date
      add :gender, :string
      add :city, :string
      add :state, :string
      add :country, :string
      add :referral_code, :string
      add :status, :string

      timestamps()
    end
  end
end
