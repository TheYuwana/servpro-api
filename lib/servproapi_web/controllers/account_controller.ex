defmodule ServproapiWeb.AccountController do
    use ServproapiWeb, :controller
    alias Servproapi.Account

    def register(conn, %{"register" => register}) do
        
        IO.inspect register
        
        conn
        |> put_status(200)
        |> render("200.json", %{data: []})
    end

end