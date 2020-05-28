defmodule Demo.Patents.ClaimEmbed do
    import Ecto.Changeset
    use Ecto.Schema
  
    embedded_schema do
      field :claim, :string
    end
  
    @fields [:claim]
  
    def changeset(claim_embed, params) do
      claim_embed
      |> cast(params, @fields)
      |> validate_required(@fields)
    end
  end