defmodule Demo.MOEFs.MOEFSettings do
  use Ecto.Schema
  import Ecto.Changeset
  
    embedded_schema do
      field :columns, :map
    end
  
    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [:columns])
    end
  end 