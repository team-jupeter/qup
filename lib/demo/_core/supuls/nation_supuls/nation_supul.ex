defmodule Demo.NationSupuls.NationSupul do
  use Ecto.Schema
  import Ecto.Changeset

  alias Demo.NationSupuls.NationSupul

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "nation_supuls" do
    field :name, :string
    field :type, :string
    field :nation_supul_code, :string

    field :auth_code, :string
    field :hash_count, :integer, default: 0
    field :hash_history, {:array, :string}, default: []
    field :current_hash, :string, default: "nation_supul origin"
    field :incoming_hash, :string

    # has_many :entities, Demo.Business.Entity
    has_many :state_supuls, Demo.StateSupuls.StateSupul
    has_many :schools, Demo.Schools.School, on_replace: :nilify

    belongs_to :global_supul, Demo.GlobalSupuls.GlobalSupul, type: :binary_id
    has_one :financial_report, Demo.Reports.FinancialReport

    timestamps()
  end

  @fields [
    :name, :auth_code, :nation_supul_code, :type, 
    :hash_history, :current_hash, :incoming_hash, :hash_count, 

  ]
  @doc false 
  def changeset(attrs = %{global_supul: global_supul}) do
    %NationSupul{}
    |> cast(attrs, @fields)
    |> validate_required([:name])
    |> put_assoc(:global_supul, attrs.global_supul)
  end

  def changeset(attrs) do
    %NationSupul{}
    |> cast(attrs, @fields)
    |> validate_required([])
  end

  def changeset(%NationSupul{} = nation_supul, attrs = %{auth_code: auth_code}) do
    IO.puts "hhhhiiii"
    nation_supul
    |> cast(attrs, @fields)
    |> validate_required([:name])
    |> put_change(:auth_code, attrs.auth_code)
  end

  def changeset(%NationSupul{} = nation_supul, attrs) do
    nation_supul
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
