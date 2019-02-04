defmodule Movielist.Reports do
  @moduledoc """
  The Reports context.
  """

  import Ecto.Query, warn: false
  alias Movielist.Repo

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

end
