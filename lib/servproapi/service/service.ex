defmodule Servproapi.Service do
    alias Servproapi.Repo
    alias Servproapi.Service.{Request}

    ####################
    # Request
    ####################
    def list_requests() do
        Request
        |> Request.with_skill
        |> Request.sort_by_start_date
        |> Repo.all()
    end

    def create_request(attrs \\ %{}, user, skill) do
        %Request{}
        |> Request.changeset(user, skill, attrs)
        |> Repo.insert
    end

    def accept_request(request, user_id) do
        new_user_id = if request.user_id != user_id do user_id else 1 end
        request
        |> Request.changeset_accept(%{user_id: new_user_id})
        |> Repo.update
    end

    def get_request_by_id(id) do
        case Repo.get_by(Request, [id: id]) do
            nil -> {:error, :not_found}
            request -> {:ok, request}
        end
    end

  end
  