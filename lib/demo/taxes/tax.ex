defmodule Demo.Taxes.Tax do
  use Ecto.Schema
  import Ecto.Changeset

  schema "taxes" do
    field :name, :string
    field :nationality, :string

    has_many :users, Demo.Accounts.User
    belongs_to :nation, Demo.Nation
    
    timestamps()
  end

  @doc false
  def changeset(tax, attrs) do
    tax
    |> cast(attrs, [:name, :nationality])
    |> validate_required([:name, :nationality])
  end
end
