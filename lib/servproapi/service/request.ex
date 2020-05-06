defmodule Servproapi.Service.Request do
    use Ecto.Schema
    import Ecto.Changeset
    alias Servproapi.Account.{Skill, User}
    alias Servproapi.Service.{Request}
    import Ecto.Query
  
    schema "requests" do
      field :client, :string
      field :subject, :string
      field :details, :string

      field :start_date, :utc_datetime
      field :end_date, :utc_datetime

      belongs_to :skill, Skill
      belongs_to :user, User
  
      timestamps()
    end
  
    @doc false
    def changeset(%Request{} = request, user, skill, attrs) do
        request
      |> cast(attrs, [:client, :subject, :details, :start_date, :end_date])
      |> validate_required([:client, :subject, :details, :start_date, :end_date], [message: "CANNOT_BE_EMPTY"])
      |> put_assoc(:user, user)
      |> put_assoc(:skill, skill)
    end

    def changeset_accept(%Request{} = request, attrs) do
      request
      |> cast(attrs, [:user_id])
    end

    def with_skill(request) do
      skill_query = 
        from sk in Skill

      from r in request,
      preload: [skill: ^skill_query]
    end

    def sort_by_start_date(request) do
      from r in request,
      order_by: [{:desc, r.start_date}, {:desc, r.client}]
    end

  end
  