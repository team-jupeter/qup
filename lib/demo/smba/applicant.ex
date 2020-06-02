defmodule Demo.SMBA.Applicant do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "applicants" do
    field :names, {:array, :map}
    field :amount, :integer

    has_one :subject, Demo.SMBA.Subject

    timestamps()
  end

  @doc false
  def changeset(apply, attrs \\ %{}) do
    apply
    |> cast(attrs, [])
    |> validate_required([])
  end
end
