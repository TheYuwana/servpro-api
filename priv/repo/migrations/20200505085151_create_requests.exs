defmodule Servproapi.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :client, :string
      add :subject, :string
      add :details, :text

      add(:start_date, :utc_datetime)
      add(:end_date, :utc_datetime)

      add :skill_id, references("skills")
      add :accepted_user_id, references("users")
      timestamps()
    end
  end
end
