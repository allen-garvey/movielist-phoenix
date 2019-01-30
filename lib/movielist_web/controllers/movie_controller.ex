defmodule MovielistWeb.MovieController do
  use MovielistWeb, :controller

  alias Movielist.Admin
  alias Movielist.Admin.Movie

  def related_fields() do
    [
      genres: Admin.list_genres() |> MovielistWeb.GenreView.map_for_form,
    ]
  end

  def index(conn, _params) do
    movies = Admin.list_movies()
    render(conn, "index.html", movies: movies)
  end

  def new(conn, _params) do
    changeset = Admin.change_movie(%Movie{})
    render(conn, "new.html", [changeset: changeset] ++ related_fields())
  end

  def create(conn, %{"movie" => movie_params}) do
    case Admin.create_movie(movie_params) do
      {:ok, movie} ->
        conn
        |> put_flash(:info, "Movie created successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", [changeset: changeset] ++ related_fields())
    end
  end

  def show(conn, %{"id" => id}) do
    movie = Admin.get_movie!(id)
    render(conn, "show.html", movie: movie)
  end

  def edit(conn, %{"id" => id}) do
    movie = Admin.get_movie!(id)
    changeset = Admin.change_movie(movie)
    render(conn, "edit.html", [movie: movie, changeset: changeset] ++ related_fields())
  end

  def update(conn, %{"id" => id, "movie" => movie_params}) do
    movie = Admin.get_movie!(id)

    case Admin.update_movie(movie, movie_params) do
      {:ok, movie} ->
        conn
        |> put_flash(:info, "Movie updated successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", [movie: movie, changeset: changeset] ++ related_fields())
    end
  end

  def delete(conn, %{"id" => id}) do
    movie = Admin.get_movie!(id)
    {:ok, _movie} = Admin.delete_movie(movie)

    conn
    |> put_flash(:info, "Movie deleted successfully.")
    |> redirect(to: Routes.movie_path(conn, :index))
  end
end
