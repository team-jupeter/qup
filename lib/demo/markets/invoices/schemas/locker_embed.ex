defmodule Demo.Invoices.ItemLockerEmbed do
    import Ecto.Changeset
    use Ecto.Schema
  
    embedded_schema do
        field :locking_use_area, {:array, :string}, default: []
        field :locking_use_until, :naive_datetime
        field :locking_output_entity_catetory, :naive_datetime
        field :locking_output_specific_entities, {:array, :string}, default: []
    end
  
    def changeset(member_embed, params) do
      member_embed
      |> cast(params, [:uid])
      |> validate_required([:uid])
    end
  end
  