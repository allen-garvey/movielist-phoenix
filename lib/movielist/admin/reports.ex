defmodule Movielist.Reports do
  @moduledoc """
  The Reports context.
  """

  import Ecto.Query, warn: false
  alias Movielist.Repo

  alias Movielist.Admin
  # alias Movielist.Admin.Genre
  alias Movielist.Admin.Movie
  alias Movielist.Admin.Rating

  @doc """
  Returns map with count of movies for genre id and their average pre-rating
  """
  def movie_stats_for_genre(genre_id) do
    from(m in Movie, where: m.genre_id == ^genre_id, select: %{movie_count: count(m), average_pre_rating: avg(m.pre_rating)})
    |> Repo.one!
  end

  @doc """
  Returns map with count of rated movies for genre id and their average score
  """
  def rating_stats_for_genre(genre_id) do
    from(r in Rating, join: m in assoc(r, :movie), where: m.genre_id == ^genre_id, select: %{rating_count: count(r), average_score: avg(r.score)})
    |> Repo.one!
  end

  @doc """
  Returns map with count of rated movies for year and their average score
  """
  def rating_stats_for_year(year) do
    from(r in Rating, join: m in assoc(r, :movie), where: fragment("EXTRACT(year FROM ?)", r.date_scored) == ^year, select: %{rating_count: count(r), average_score: coalesce(avg(r.score), 0)})
    |> Repo.one!
  end

  @doc """
  Returns list of ratings by year
  """
  def list_ratings_for_year(year, :date) do
    Admin.list_ratings_base_query()
    |> where([r], fragment("EXTRACT(year FROM ?)", r.date_scored) == ^year)
    |> order_by(asc: :date_scored, asc: :id, desc: :score)
    |> Repo.all
  end

  def list_ratings_for_year(year, :score) do
    Admin.list_ratings_base_query()
    |> where([r], fragment("EXTRACT(year FROM ?)", r.date_scored) == ^year)
    |> order_by(desc: :score, asc: :date_scored, asc: :id)
    |> Repo.all
  end

end
