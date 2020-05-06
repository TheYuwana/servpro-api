defmodule ServproapiWeb.AccountController do
    use ServproapiWeb, :controller
    alias Servproapi.Account

    action_fallback ServproapiWeb.FallbackController

    def register(conn, %{"user" => user, "skills" => skills}) do
        with(
            :ok <- skill_count(skills),
            {:ok, user} <- Account.create_user_with_skills(user, skills)
        ) do
            conn
            |> put_status(201)
            |> render("201.json", 
            %{  
                data: nil
            })
        end
    end

    defp skill_count(skills) do
        if Enum.count(skills) < 3 do 
            {:error, "Skills", [%{field: "skills", error: "NO_SKILL_SELECTED"}], %{}}
        else
            :ok
        end
    end

    def get_user(conn, %{"name" => name}) do
        with(
            {:ok, user} <- Account.get_user_by_name(name)
        ) do
            conn
            |> put_status(201)
            |> render("user.json", %{user: user})
        end
    end

    def list_skills(conn, _params) do
        with(
            skills <- Account.list_skills()
        ) do
            conn
            |> put_status(200)
            |> render("list_skills.json", %{skills: skills})
        end
    end

end