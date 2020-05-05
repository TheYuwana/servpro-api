defmodule ServproapiWeb.ServiceController do
    use ServproapiWeb, :controller
    alias Servproapi.Service

    action_fallback ServproapiWeb.FallbackController

    def list(conn, _params) do
        with(
            requests <- Service.list_requests()
        ) do
            conn
            |> put_status(200)
            |> render("list.json", %{requests: requests})
        end
    end

end