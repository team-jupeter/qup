defmodule Demo.Reports.Report do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reports" do

    timestamps()
  end

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, [])
    |> validate_required([])
  end
end
