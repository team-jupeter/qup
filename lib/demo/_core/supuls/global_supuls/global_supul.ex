defmodule Demo.Supuls.GlobalSupul do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "global_supuls" do
    field :name, :string

    field :global_signature, :string
    field :private_key, :string
    field :public_key, :string

    has_many :nation_supuls, Demo.Supuls.NationSupul
    has_many :schools, Demo.Schools.School, on_replace: :nilify

    has_one :financial_report, Demo.Reports.FinancialReport
    has_one :mulet, Demo.Mulets.Mulet

    timestamps()
  end

  @fields [
    :name, :global_signature, :private_key, :public_key, 
  ]

  @doc false
  def changeset(global_supul, attrs) do
    global_supul
    |> cast(attrs, @fields)
    |> validate_required([:name])
  end
end
