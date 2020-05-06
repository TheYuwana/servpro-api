defmodule ServproapiWeb.ServiceController do
    use ServproapiWeb, :controller
    alias Servproapi.Service
    alias Servproapi.Account

    action_fallback ServproapiWeb.FallbackController

    # Requests based on user skills
    def list(conn, %{"user_id" => user_id}) do
        with(
            {:ok, user} <- Account.get_user_by_id(user_id),
            skill_requests <- Account.list_user_skills_requests(user.id)
        ) do

            requests = Enum.map(skill_requests, fn sr -> 
                sr.skill.requests
            end)
            |> List.flatten

            conn
            |> put_status(200)
            |> render("list.json", %{requests: requests})
        end
    end

    def list(conn, _params) do
        with(
            requests <- Service.list_requests()
        ) do
            conn
            |> put_status(200)
            |> render("list.json", %{requests: requests})
        end
    end

    def update_request(conn, %{"request_id" => request_id, "user_id" => user_id}) do
        with(
            {:ok, user} <- Account.get_user_by_id(user_id),
            {:ok, request} <- Service.get_request_by_id(request_id),
            :ok <- check_conflicting_requests(request, user),
            {:ok, _updated_request} <- Service.accept_request(request, user.id)
        ) do
            conn
            |> put_status(200)
            |> render("200.json", %{data: nil})
        end
    end

    defp check_conflicting_requests(target_request, user) do

        target_date = DateTime.to_date(target_request.start_date)

        result = Enum.any?(user.accepted_requests, fn request -> 
            if target_request.id != request.id do
                request_date = DateTime.to_date(request.start_date)
                Date.compare(target_date, request_date) == :eq
            else
                false
            end
        end)

        case result do
            true -> 
                {:error, "request", [%{field: "request", error: "DATE_CONFLICT"}], %{}}
            false ->
                :ok
        end
    end

end