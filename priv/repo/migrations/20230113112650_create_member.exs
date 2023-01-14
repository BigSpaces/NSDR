defmodule Nsdr.Repo.Migrations.CreateMember do
  use Ecto.Migration

  def change do
    create table(:member) do
      add :name, :string
      add :email, :string

      timestamps()
    end
  end
end
