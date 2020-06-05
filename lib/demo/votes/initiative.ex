defmodule Demo.Votes.Initiative do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "initiatives" do
    field :initiators, {:array, :binary_id}
    field :num_of_initiators, :integer
    field :type, :string
    field :lawyers, {:array, :binary_id}
    field :supports, :integer
    field :supporters, {:array, :binary_id}
    field :legal_review, :string

    belongs_to :constitution, Demo.Votes.Constitution, type: :binary_id
    belongs_to :law, Demo.Votes.Law, type: :binary_id
    belongs_to :ordinance, Demo.Votes.Ordinance, type: :binary_id
    belongs_to :rule, Demo.Votes.Rule, type: :binary_id


    timestamps()
  end

  @fields [
    :initiators,
    :num_of_initiators, 
    :type, 
    :lawyers,
    :supports,
    :constitution_id,
    :law_id,
    :ordinance_id,
    :rule_id,
    :supporters
  ]
  @doc false
  def changeset(initiative, attrs) do
    initiative
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
