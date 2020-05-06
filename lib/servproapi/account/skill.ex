defmodule Servproapi.Account.Skill do
    use Ecto.Schema
    import Ecto.Changeset
    alias Servproapi.Account.{Skill, UserSkill}
    alias Servproapi.Service.{Request}
    import Ecto.Query
  
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

    def with_user_requests(skill, user_id) do
      request_query = 
        from r in Request,
        where: r.user_id == ^user_id

      from s in skill,
      preload: [accepted_requests: ^request_query]
    end

  end
  