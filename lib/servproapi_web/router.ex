defmodule ServproapiWeb.Router do
  use ServproapiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ServproapiWeb do
    pipe_through :api
  end
end
