defmodule Servproapi.Service.Request do
    use Ecto.Schema
    import Ecto.Changeset
    alias Servproapi.Account.{Skill, User}
    alias Servproapi.Service.{Request}
    # import Ecto.Query
  
    schema "requests" do
      field :client, :string
      field :subject, :string
      field :details, :string

      field :start_date, :utc_datetime
      field :end_date, :utc_datetime

      belongs_to :skill, Skill
      belongs_to :accepted_user, User
  
      timestamps()
    end
  
    @doc false
    def changeset(%Request{} = request, accepted_user, skill, attrs) do
        request
      |> cast(attrs, [:client, :subject, :details, :start_date, :end_date])
      |> validate_required([:client, :subject, :details, :start_date, :end_date], [message: "CANNOT_BE_EMPTY"])
      |> put_assoc(:accepted_user, accepted_user)
      |> put_assoc(:skill, skill)
    end

  end
  