defmodule MovielistWeb.PageController do
  use MovielistWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
