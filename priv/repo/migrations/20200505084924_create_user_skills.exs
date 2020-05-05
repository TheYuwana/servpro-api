defmodule Servproapi.Repo.Migrations.CreateUserSkills do
  use Ecto.Migration

  def change do
    create table(:user_skills) do
      add :user_id, references("users")
      add :skill_id, references("skills")
      add :scale, :int
      timestamps()
    end
  end
end
