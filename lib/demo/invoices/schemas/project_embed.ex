defmodule Demo.Companies.ProjectEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :project_name, :string
  end

  def changeset(project_embed, params) do
    project_embed
    |> cast(params, [:project_name])
    |> validate_required([:project_name])
  end
end
