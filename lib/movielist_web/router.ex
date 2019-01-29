defmodule MovielistWeb.Router do
  use MovielistWeb, :router

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

  scope "/", MovielistWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/genres", GenreController
  end

  # Other scopes may use custom stacks.
  # scope "/api", MovielistWeb do
  #   pipe_through :api
  # end
end
