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
      put "/skills", AccountController, :update_skills
    end

    scope "/request" do
      get "/list", ServiceController, :list
      put "/accept", ServiceController, :update_request
    end

  end
end
