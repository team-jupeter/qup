defmodule Demo.MOEFs.MOEF do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "moefs" do
      embeds_one :settings, Demo.MOEFs.MOEFSettings
      timestamps()
  end

  @doc false
  def changeset(moef, params \\ %{}) do
    moef
    |> cast(params, [])
    |> cast_embed(:settings) 
  end
end
