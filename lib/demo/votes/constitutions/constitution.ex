defmodule Demo.Votes.Constitution do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "constitutions" do
    field :nationality, :string
    field :content, :string
    field :content_hash, :string
    field :empowered_on, :naive_datetime
    field :signed_by, {:array, :string}, default: []
 
    has_one :initiative, Demo.Votes.Initiative

    has_many :users, Demo.Accounts.User
    has_many :votes, Demo.Votes.Vote

    belongs_to :nation, Demo.Nations.Nation

    timestamps()
  end
  @fields [
   :content,
   :empowered_on, 
   :nationality,
  ]
  @doc false
  def changeset(constitution, attrs \\ %{}) do
    constitution
    |> cast(attrs, @fields)
    |> validate_required([])
  end

end
