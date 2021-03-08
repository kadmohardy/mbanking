defmodule Mbanking.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :cpf, :string
      add :birth_date, :date
      add :gender, :string
      add :city, :string
      add :state, :string
      add :countrystatus, :string
      add :referral_code, :string

      timestamps()
    end

  end
end
