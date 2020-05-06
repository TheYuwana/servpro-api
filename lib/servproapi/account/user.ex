defmodule Servproapi.Account.User do
    use Ecto.Schema
    import Ecto.Changeset
    alias Servproapi.Account.{User, UserSkill, Skill}
    alias Servproapi.Service.{Request}
    import Ecto.Query

    def avatars, do: ["avatar-1", "avatar-2", "avatar-3", "avatar-4", "avatar-5"]

    schema "users" do
      field :name, :string
      field :age, :integer
      field :picture, :string

      has_many :skills, UserSkill
      has_many :accepted_requests, Request
  
      timestamps()
    end
  
    @doc false
    def changeset(%User{} = user, attrs) do
      user
      |> cast(attrs, [:name, :age, :picture])
      |> validate_required([:name, :age], [message: "CANNOT_BE_EMPTY"])
      |> unique_constraint(:name, [message: "NAME_TAKEN"])
      |> validate_inclusion(:picture, avatars(), message: "INVALID_PICTURE")
    end

    def with_skills(user) do
      skill_query = 
        from sk in Skill
      
      userskill_query =
        from usk in UserSkill,
        preload: [skill: ^skill_query]

      from u in user,
      preload: [skills: ^userskill_query]
    end

    def with_requests(user) do
      request_query = 
        from r in Request

      from u in user,
      preload: [accepted_requests: ^request_query]
    end

  end
  