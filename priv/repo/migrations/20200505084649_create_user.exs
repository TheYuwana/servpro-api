defmodule Servproapi.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :age, :int
      add :picture, :string

      timestamps()
    end

    create unique_index(:users, [:name])
  end
end
