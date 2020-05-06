defmodule ServproapiWeb.Router do
  use ServproapiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ServproapiWeb do
    pipe_through :api

    scope "/account" do
      get "/user/:name", AccountController, :get_user
      post "/register", AccountController, :register
      get "/list-skills", AccountController, :list_skills
    end

    scope "/request" do
      get "/list", ServiceController, :list
    end

  end
end
