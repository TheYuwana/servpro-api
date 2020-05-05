defmodule Servproapi.Service do
    alias Servproapi.Repo
    alias Servproapi.Service.{Request}

    ####################
    # Request
    ####################
    def list_requests() do
        Request
        |> Request.with_skill
        |> Repo.all()
    end

    def create_request(attrs \\ %{}, user, skill) do
        %Request{}
        |> Request.changeset(user, skill, attrs)
        |> Repo.insert
    end

  end
  