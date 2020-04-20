defmodule Demo.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :category, :string
    field :name, :string
    field :year_started, :integer
    field :year_ended, :integer
    field :gru_price, :integer

    has_many :teams, Demo.Companies.Team
    belongs_to :nation, Demo.Nations.Nation
    
    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :category])
    |> validate_required([:name, :category])
  end
end
