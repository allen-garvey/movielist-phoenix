defmodule MovielistWeb.ReportsController do
  use MovielistWeb, :controller

  alias Movielist.Reports

  def report_for_year(conn, year, sort) when is_integer(year) and is_atom(sort) do
    rating_stats = Reports.rating_stats_for_year(year)
    ratings = Reports.list_ratings_for_year(year, sort)

    render(conn, "show.html", 
      page_atom: :reports_show,
      year: year,
      ratings: ratings,
      rating_count: rating_stats[:rating_count], 
      average_score: rating_stats[:average_score]
    )
  end

  def show(conn, %{"year" => year_raw, "sort" => "date"}) do
    case Integer.parse(year_raw) do
      {year, _} -> report_for_year(conn, year, :date)
      _         -> redirect(conn, to: MovielistWeb.ReportsView.reports_for_current_year_score_sorted_path(conn))
    end
  end

  def show(conn, %{"year" => year_raw}) do
    case Integer.parse(year_raw) do
      {year, _} -> report_for_year(conn, year, :score)
      _         -> redirect(conn, to: MovielistWeb.ReportsView.reports_for_current_year_path(conn))
    end
  end

  
end
