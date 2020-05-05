defmodule Servproapi.Account.Skill do
    use Ecto.Schema
    import Ecto.Changeset
    alias Servproapi.Account.{Skill, UserSkill}
    alias Servproapi.Service.{Request}
    # import Ecto.Query
  
    schema "skills" do
      field :name, :string
      has_many :requests, Request
      has_many :users, UserSkill
  
      timestamps()
    end
  
    @doc false
    def changeset(%Skill{} = skill, attrs) do
      skill
      |> cast(attrs, [:name])
      |> validate_required([:name], [message: "CANNOT_BE_EMPTY"])
    end

  end
  