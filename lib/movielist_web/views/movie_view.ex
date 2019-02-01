defmodule MovielistWeb.MovieView do
  use MovielistWeb, :view

  def to_s(movie) do
  	movie.title
  end

  @doc """
  Maps a list of movies into tuples, used for forms
  """
  def map_for_form(movies) do
    Enum.map(movies, &{to_s(&1), &1.id})
  end

  @doc """
  String representation of active status
  """
  def is_active_status(is_active) do
    case is_active do
      true  -> "Active"
      false -> "Inactive"
    end
  end

  @doc """
  CSS class for button of movie show pages to change active status
  """
  def active_button_class(is_active) do
    case is_active do
      true  -> "btn-primary"
      false -> "btn-default"
    end
  end
end
