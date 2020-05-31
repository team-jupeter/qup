
defmodule Demo.ABC.ABCLockerEmbed do
    import Ecto.Changeset
    use Ecto.Schema
  
    embedded_schema do
        field :locked, :boolean, default: false
        field :locking_use_area, {:array, :string}, default: []
        field :locking_use_until, :naive_datetime 
        field :locking_output_entity_catetory, {:array, :string}, default: []
        field :locking_output_specific_entities, {:array, :string}, default: []
        field :locking_output_specific_dates, {:array, :naive_datetime}, default: []
    end
  
    def changeset(member_embed, params) do
      member_embed
      |> cast(params, [:uid])
      |> validate_required([:uid])
    end
  end
  