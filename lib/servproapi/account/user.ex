defmodule Servproapi.Account.User do
    use Ecto.Schema
    import Ecto.Changeset
    alias Servproapi.Account.{User, UserSkill}
    alias Servproapi.Service.{Request}
    # import Ecto.Query
  
    schema "users" do
      field :name, :string
      field :age, :integer
      field :picture, :string

      has_many :skills, UserSkill
      has_many :accepted_requests, Request
  
      timestamps()
    end
  
    @doc false
    def changeset(%User{} = user, attrs) do
      user
      |> cast(attrs, [:name, :age, :picture])
      |> validate_required([:name, :age, :picture], [message: "CANNOT_BE_EMPTY"])
      |> unique_constraint(:name, [message: "NAME_TAKEN"])
    end

  end
  