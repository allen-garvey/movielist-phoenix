defmodule MovielistWeb.RatingController do
  use MovielistWeb, :controller

  alias Movielist.Admin
  alias Movielist.Admin.Rating

  def index(conn, _params) do
    ratings = Admin.list_ratings()
    render(conn, "index.html", ratings: ratings)
  end

  def new(conn, _params) do
    changeset = Admin.change_rating(%Rating{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"rating" => rating_params}) do
    case Admin.create_rating(rating_params) do
      {:ok, rating} ->
        conn
        |> put_flash(:info, "Rating created successfully.")
        |> redirect(to: Routes.rating_path(conn, :show, rating))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    rating = Admin.get_rating!(id)
    render(conn, "show.html", rating: rating)
  end

  def edit(conn, %{"id" => id}) do
    rating = Admin.get_rating!(id)
    changeset = Admin.change_rating(rating)
    render(conn, "edit.html", rating: rating, changeset: changeset)
  end

  def update(conn, %{"id" => id, "rating" => rating_params}) do
    rating = Admin.get_rating!(id)

    case Admin.update_rating(rating, rating_params) do
      {:ok, rating} ->
        conn
        |> put_flash(:info, "Rating updated successfully.")
        |> redirect(to: Routes.rating_path(conn, :show, rating))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", rating: rating, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    rating = Admin.get_rating!(id)
    {:ok, _rating} = Admin.delete_rating(rating)

    conn
    |> put_flash(:info, "Rating deleted successfully.")
    |> redirect(to: Routes.rating_path(conn, :index))
  end
end
