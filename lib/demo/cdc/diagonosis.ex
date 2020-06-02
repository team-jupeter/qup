defmodule Demo.CDC.Diagnosis do
    use Ecto.Schema
    import Ecto.Changeset

    @primary_key {:id, :binary_id, autogenerate: true}
    schema "diagnoses" do
        field :collection_date, :date
        field :received_date, :date
        field :reported_date, :date

        field :client, :binary_id
        field :doctor, :binary_id
        field :clinic, :binary_id
        field :test_name, :string
        field :meditations, {:array, :string}

        has_many :metabolic_panels, Demo.CDC.MetabolicPanel
        embeds_many :medical_images, Demo.CDC.MedicalImageEmbed

        belongs_to :health_report, Demo.CDC.HealthReport, type: :binary_id
        timestamps()
    end
  
    @fields [
      :client, :doctor, :clinic, :test_name, :meditations
    ]
    @doc false
    def changeset(diagnosis, attrs \\ %{}) do
      diagnosis
      |> cast(attrs, @fields)
      |> validate_required([])
      |> cast_assoc(:metabolic_panels)
    end
  end
