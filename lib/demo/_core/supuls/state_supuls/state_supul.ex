defmodule Demo.Supuls.StateSupul do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "state_supuls" do
    field :name, :string
    field :nation_name, :string

    field :payload, :string
    field :payload_hash, :string

    has_many :supuls, Demo.Supuls.Supul
    # has_many :entities, Demo.Business.Entity
    has_many :schools, Demo.Schools.School, on_replace: :nilify

    has_one :financial_report, Demo.Reports.FinancialReport
    has_one :mulet, Demo.Mulets.Mulet
    
    belongs_to :nation_supul, Demo.Supuls.NationSupul, type: :binary_id
    
    timestamps()
  end

  @fields [
    :name, :nation_name, 
    :payload, :payload_hash
  ]
  @doc false
  def changeset(state_supul, attrs) do
    state_supul
    |> cast(attrs, @fields)
    |> validate_required([:name])
  end
end
