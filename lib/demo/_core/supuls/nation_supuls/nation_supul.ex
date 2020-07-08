defmodule Demo.NationSupuls.NationSupul do
  use Ecto.Schema
  import Ecto.Changeset

  alias Demo.NationSupuls.NationSupul

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "nation_supuls" do
    field :type, :string
    field :name, :string

    field :auth_code, :string
    field :payload, :string
    field :payload_hash, :string

    # has_many :entities, Demo.Business.Entity
    has_many :state_supuls, Demo.StateSupuls.StateSupul
    has_many :schools, Demo.Schools.School, on_replace: :nilify

    belongs_to :global_supul, Demo.GlobalSupuls.GlobalSupul, type: :binary_id
    has_one :financial_report, Demo.Reports.FinancialReport
    has_one :mulet, Demo.Mulets.Mulet

    timestamps()
  end

  @fields [
    :name, :payload, :payload_hash, :auth_code
  ]
  @doc false
  def changeset(attrs) do
    %NationSupul{}
    |> cast(attrs, @fields)
    |> validate_required([:name])
    |> put_assoc(:global_supul, attrs.global_supul)
  end

  def changeset(%NationSupul{} = nation_supul, attrs = %{auth_code: auth_code}) do
    nation_supul
    |> cast(attrs, @fields)
    |> validate_required([:name])
    |> put_change(:auth_code, attrs.auth_code)
  end
end
