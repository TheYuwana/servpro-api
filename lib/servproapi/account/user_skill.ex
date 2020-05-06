defmodule Servproapi.Account.UserSkill do
    use Ecto.Schema
    import Ecto.Changeset
    alias Servproapi.Account.{UserSkill, Skill, User}
    alias Servproapi.Service.Request
    import Ecto.Query
  
    schema "user_skills" do
      field :scale, :integer
      belongs_to :skill, Skill
      belongs_to :user, User
  
      timestamps()
    end
  
    @doc false
    def changeset(%UserSkill{} = user_skill, user, skill, attrs) do
      user_skill
      |> cast(attrs, [:scale])
      |> validate_required([:scale], [message: "CANNOT_BE_EMPTY"])
      |> validate_inclusion(:scale, 0..10)
      |> put_assoc(:user, user)
      |> put_assoc(:skill, skill)
    end

    def by_user(user_skill, user_id) do
      from us in user_skill,
      where: us.user_id == ^user_id
    end

    def with_skill_and_requests(user_skill) do
      request_skill_query = 
        from rs in Skill

      request_query = 
        from r in Request,
        preload: [skill: ^request_skill_query]
      
      skill_query = 
        from s in Skill,
        preload: [requests: ^request_query]

      from us in user_skill,
      preload: [skill: ^skill_query]
    end

  end
  