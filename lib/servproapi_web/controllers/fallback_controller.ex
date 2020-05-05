defmodule ServproapiWeb.FallbackController do
    use ServproapiWeb, :controller

    # 404 errors
    def call(conn, {:error, :not_found}) do
        conn
        |> put_status(404)
        |> put_view(ServproapiWeb.ErrorView)
        |> render("404.json", %{message: "Not found"})
    end

    # Changeset errors
    def call(conn, {:error, _multi_field, %Ecto.Changeset{} = changeset, _data}), do: show_changeset_error(conn, changeset)
    def call(conn, {:error, %Ecto.Changeset{} = changeset}), do: show_changeset_error(conn, changeset)
    def show_changeset_error(conn, changeset) do
        errors = Enum.map(changeset.errors, fn {field, {msg, _constraints}} -> 
            %{
                field: field,
                error: msg
            }
        end)
        
        conn
        |> put_status(400)
        |> put_view(ServproapiWeb.ErrorView)
        |> render("400.json", %{data: errors})
    end

    # Custom errors
    def call(conn, {:error, _multi_field, errors, _data}) do
        conn
        |> put_status(400)
        |> put_view(ServproapiWeb.ErrorView)
        |> render("400.json", %{data: errors})
    end

    # Catch all
    def call(conn, error) do
        IO.puts "=================== UNCAUGHT ERROR!! ==================="
        IO.inspect error
        conn
        |> put_status(500)
        |> put_view(ServproapiWeb.ErrorView)
        |> render("500.json", 
            %{
                message: "Something went wrong",
                data: nil
            }
        )
    end

end