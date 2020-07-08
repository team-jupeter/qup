defmodule Demo.StateSupuls.StateSupul do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.StateSupuls.StateSupul

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "state_supuls" do
    field :type, :string
    field :name, :string
    field :nation_name, :string

    field :auth_code, :string
    field :payload, :string
    field :payload_hash, :string

    has_many :supuls, Demo.Supuls.Supul
    # has_many :entities, Demo.Business.Entity
    has_many :schools, Demo.Schools.School, on_replace: :nilify

    has_one :financial_report, Demo.Reports.FinancialReport
    has_one :mulet, Demo.Mulets.Mulet
    
    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id
    
    timestamps()
  end

  @fields [
    :name, :nation_name, :auth_code, :payload, :payload_hash
  ]
  @doc false
  def changeset(attrs) do
    %StateSupul{}
    |> cast(attrs, @fields)
    |> validate_required([:name])
    |> put_assoc(:nation_supul, attrs.nation_supul)
  end

  def changeset(%StateSupul{} = state_supul, attrs = %{auth_code: auth_code}) do
    state_supul
    |> cast(attrs, @fields)
    |> validate_required([:name])
    |> put_change(:auth_code, attrs.auth_code)
  end

end
