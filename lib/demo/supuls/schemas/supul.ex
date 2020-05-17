defmodule Demo.Supuls.Supul do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "supuls" do
    field :supul_code, :integer
    field :geographical_area, :string
    field :name, :string

    has_one :financial_report, Demo.Reports.FinancialReport
    belongs_to :state_supul, Demo.Supuls.StateSupul, type: :binary_id

    timestamps()
  end

  @doc false
  @field [:name, :geographical_area, :supul_code, :state_supul_id]
  def changeset(supul, attrs) do
    supul
    |> cast(attrs, @field)
    |> validate_required([])
  end
end
