defmodule Ironclad.Router do
  use Ironclad.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Ironclad do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/playground", PlaygroundController, :index
    post "/playground", PlaygroundController, :query
    resources "/databases", DatabaseController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ironclad do
  #   pipe_through :api
  # end
end
