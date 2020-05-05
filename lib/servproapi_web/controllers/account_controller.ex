defmodule ServproapiWeb.AccountController do
    use ServproapiWeb, :controller
    alias Servproapi.Account

    action_fallback ServproapiWeb.FallbackController

    def register(conn, %{"user" => user, "skills" => skills}) do
        with(
            {:ok, user} <- Account.create_user_with_skills(user, skills)
        ) do
            conn
            |> put_status(201)
            |> render("201.json", 
            %{  
                data: %{
                    name: user.name
                }
            })
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

end