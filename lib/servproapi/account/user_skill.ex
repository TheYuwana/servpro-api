defmodule Servproapi.Account.UserSkill do
    use Ecto.Schema
    import Ecto.Changeset
    alias Servproapi.Account.{UserSkill, Skill, User}
    # import Ecto.Query
  
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

  end
  