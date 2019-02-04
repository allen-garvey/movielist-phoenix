defmodule MovielistWeb.ReportsController do
  use MovielistWeb, :controller

  alias Movielist.Reports

  def report_for_year(conn, year) when is_integer(year) do
    rating_stats = Reports.rating_stats_for_year(year)
    ratings = Reports.list_ratings_for_year(year)

    render(conn, "show.html", 
      page_atom: :reports_show,
      year: year,
      ratings: ratings,
      rating_count: rating_stats[:rating_count], 
      average_score: rating_stats[:average_score]
    )
  end

  def show(conn, %{"year" => year_raw}) do
    case Integer.parse(year_raw) do
      {year, _} -> report_for_year(conn, year)
      _         -> redirect(conn, to: MovielistWeb.ReportsView.reports_for_current_year_path(conn))
    end
  end

  
end
