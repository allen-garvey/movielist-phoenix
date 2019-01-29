defmodule Movielist.Admin.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  alias Movielist.Admin.ModelHelpers


  schema "movies" do
    field :home_release_date, :date
    field :is_active, :boolean, default: true
    field :pre_rating, :integer
    field :theater_release_date, :date
    field :title, :string

    belongs_to :genre, Movielist.Admin.Genre

    timestamps()
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :genre_id, :theater_release_date, :home_release_date, :pre_rating, :is_active])
    |> validate_required([:title, :genre_id, :pre_rating, :is_active])
    |> ModelHelpers.validate_score(:pre_rating)
    |> assoc_constraint(:genre)
  end
end
