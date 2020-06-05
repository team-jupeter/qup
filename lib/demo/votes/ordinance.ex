defmodule Demo.Votes.Ordinance do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "ordinances" do
    field :previous_contents, :binary_id
    field :previous_hash, :string
    field :current_hash, :string
    field :article, :integer
    field :clause, :integer
    field :suggested_update, :string
    field :empowered_on, :naive_datetime

    has_many :votes, Demo.Votes.Vote
    has_one :initiative, Demo.Votes.Initiative

    timestamps()
  end
  @fields [

  ]
  @doc false
  def changeset(ordinance, attrs \\ %{}) do
    ordinance
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
