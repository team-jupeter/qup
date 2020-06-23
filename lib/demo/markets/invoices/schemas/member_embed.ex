defmodule Demo.Companies.MemberEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :uid, :string
  end

  def changeset(member_embed, params) do
    member_embed
    |> cast(params, [:uid])
    |> validate_required([:uid])
  end
end
