defmodule Demo.GlobalSupuls.GlobalSupul do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true} 
  schema "global_supuls" do
    field :type, :string
    field :name, :string

    field :auth_code, :string
    field :hash_count, :integer, default: 0
    field :hash_history, {:array, :string}, default: []
    field :current_hash, :string
    field :incoming_hash, :string

    has_many :nation_supuls, Demo.NationSupuls.NationSupul
    has_many :schools, Demo.Schools.School, on_replace: :nilify

    has_one :financial_report, Demo.Reports.FinancialReport
    has_one :mulet, Demo.Mulets.Mulet

    timestamps()
  end

  @fields [
    :name, :auth_code,
    :hash_history, :current_hash, :incoming_hash, :hash_count, 
  ]

  @doc false
  def changeset(global_supul, attrs) do
    global_supul
    |> cast(attrs, @fields)
    |> validate_required([:name])
  end
end
