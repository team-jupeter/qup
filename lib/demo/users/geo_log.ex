defmodule Demo.GeoLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "geo_logs" do
    field :latitude, :string
    field :longitude, :string
    field :altitude, :string
    field :date_time, :naive_datetime

    belongs_to :user, Demo.User.User, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(geo_log, attrs) do
    geo_log
    |> cast(attrs, [])
    |> validate_required([])
  end
end
