defmodule Servproapi.Account do
    alias Servproapi.Repo
    alias Servproapi.Account.{UserSkill, Skill, User}

    ####################
    # User
    ####################
    def list_users() do
        Repo.all(User)
    end

    def create_user(attrs \\ %{}) do
        %User{}
        |> User.changeset(attrs)
        |> Repo.insert
    end

    def get_user_by_name(name) do
        case Repo.get_by(User, [name: name]) do
            nil -> {:error, :not_found}
            user -> {:ok, user}
        end
    end

    ####################
    # Skill
    ####################
    def list_skills() do
        Repo.all(Skill)
    end

    def create_skill(attrs \\ %{}) do
        %Skill{}
        |> Skill.changeset(attrs)
        |> Repo.insert
    end

    def get_skill_by_name(name) do
        case Repo.get_by(Skill, [name: name]) do
            nil -> {:error, :not_found}
            skill -> {:ok, skill}
        end
    end

    ####################
    # User skill
    ####################
    def list_user_skills() do
        Repo.all(UserSkill)
    end

    def create_user_skill(scale, user, skill) do
        %UserSkill{}
        |> UserSkill.changeset(user, skill, %{scale: scale})
        |> Repo.insert
    end

  end
  