defmodule MovielistWeb.RatingView do
  use MovielistWeb, :view

  alias MovielistWeb.MovieView
  alias MovielistWeb.SharedView

  def to_s(rating) do
  	MovieView.to_s(rating.movie) <> "—" <> SharedView.us_formatted_date(rating.date_scored)
  end

  def to_s_short(rating) do
  	SharedView.us_formatted_date(rating.date_scored) <> "—" <> Integer.to_string(rating.score)
  end


end
