defmodule Demo.Supuls.StateSupul do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "state_supuls" do
    field :name, :string

    has_many :supuls, Demo.Supuls.Supul
    belongs_to :nation_supul, Demo.Supuls.NationSupul, type: :binary_id
    has_one :financial_report, Demo.Reports.FinancialReport

    timestamps()
  end

  @doc false
  def changeset(state_supul, attrs) do
    state_supul
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
