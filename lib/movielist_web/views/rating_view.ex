defmodule MovielistWeb.RatingView do
  use MovielistWeb, :view

  alias MovielistWeb.MovieView
  alias MovielistWeb.SharedView

  def to_s(rating) do
  	MovieView.to_s(rating.movie) <> "—" <> SharedView.us_formatted_date(rating.date_scored)
  end


end
