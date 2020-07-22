defmodule Demo.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Entities.Entity

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "groups" do
    field :type, :string
    field :title, :string

    belongs_to :family, Demo.Families.Family, type: :binary_id

    many_to_many(
      :entities,
      Entity,
      # join_through: Demo.Groups.EntitiesGroups,
      join_through: "entities_groups",
      on_replace: :delete
    )

    timestamps()
  end

  @fields [
    :type, :title, 
  ]
  @doc false
  def changeset(group, attrs = %{entities: entities}) do
    group
    |> cast(attrs, @fields)
    |> put_assoc(:entities, entities)
  end
  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
