defmodule Demo.Supuls.NationSupul do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "nation_supuls" do
    field :name, :string

    has_many :state_supuls, Demo.Supuls.StateSupul
    has_many :schools, Demo.Schools.School, on_replace: :nilify

    belongs_to :global_supul, Demo.Supuls.GlobalSupul, type: :binary_id
    has_one :financial_report, Demo.Reports.FinancialReport
    has_one :mulet, Demo.Mulets.Mulet

    timestamps()
  end

  @doc false
  def changeset(nation_supul, attrs) do
    nation_supul
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
