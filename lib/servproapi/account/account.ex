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

    def create_user_with_skills(user_attrs, skills) do
        multi = Ecto.Multi.new()
        |> Ecto.Multi.insert("user", User.changeset(%User{}, user_attrs))

        Enum.reduce(skills, multi, fn skill, multi -> 
            Ecto.Multi.run(multi, "skill_#{skill["name"]}", fn repo, changes ->
                case get_skill_by_name(skill["name"]) do
                    {:ok, found_skill} ->
                        %UserSkill{}
                        |> UserSkill.changeset(changes["user"], found_skill, %{scale: skill["scale"]})
                        |> repo.insert()

                    nil ->
                        {:error, [%{field: "skills", error: "#{skill["name"]} not found"}]}
                end
            end)
        end)
        |> Repo.transaction()
    end

    def get_user_by_name(name) do
        result = User
        |> User.with_skills
        |> Repo.get_by([name: name])

        case result do
            nil -> {:error, :not_found}
            user -> {:ok, user}
        end
    end

    def get_user_by_id(id) do
        result = User
        |> User.with_requests()
        |> User.with_skills()
        |> Repo.get_by([id: id])

        case result do
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

    def list_user_skills_requests(user_id) do
        UserSkill
        |> UserSkill.by_user(user_id)
        |> UserSkill.with_skill_and_requests
        |> Repo.all()
    end

    def create_user_skill(scale, user, skill) do
        %UserSkill{}
        |> UserSkill.changeset(user, skill, %{scale: scale})
        |> Repo.insert
    end

    def update_user_skills(user, skills) do
        
        # IO.puts "===================================="
        # IO.inspect user.skills

        # Enum.each(user.skills, fn skill -> 
        #     Repo.
        # end)


        {:ok, nil}

    end

  end
  