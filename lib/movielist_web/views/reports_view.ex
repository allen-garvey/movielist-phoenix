defmodule MovielistWeb.ReportsView do
  use MovielistWeb, :view

  @doc """
  Returns a link to the reports for the current year
  """
  def reports_for_current_year_path(conn) do
    reports_for_year_path(conn, Date.utc_today.year)
  end

  def reports_for_current_year_score_sorted_path(conn) do
    reports_for_year_path_score_sorted(conn, Date.utc_today.year)
  end

  @doc """
  Returns a link to the reports for the given year
  """
  def reports_for_year_path(conn, year) do
    Routes.reports_path(conn, :show, year)
  end

  @doc """
  Returns a link to the reports for the given year
  with ratings sorted by score
  """
  def reports_for_year_path_score_sorted(conn, year) do
    Routes.reports_path(conn, :show, year, sort: :score)
  end

end
