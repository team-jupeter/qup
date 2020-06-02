defmodule Demo.SMBA.Subject do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "subjects" do
    field :category, :string
    field :starting_date, :naive_datetime
    field :ending_date, :naive_datetime
    field :interest_rate, :decimal, precision: 6, scale: 4
    field :self_funding_ratio,  :decimal, precision: 3, scale: 1
    field :documents, {:array, :binary_id}, default: []
    field :applicants, {:array, :binary_id}, default: []
    
    belongs_to :applicant, Demo.SMBA.Applicant, type: :binary_id
    
    timestamps()
  end

  @doc false
  def changeset(subject, attrs \\ %{}) do
    subject
    |> cast(attrs, [])
    |> validate_required([])
  end
end
