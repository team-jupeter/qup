defmodule Demo.CDC.Diagnosis do
    use Ecto.Schema
    import Ecto.Changeset

    @primary_key {:id, :binary_id, autogenerate: true}
    schema "diagnoses" do
        field :client, :binary_id
        field :doctor, :binary_id
        field :clinic, :binary_id
        field :test_name, :string
        field :meditations, {:array, :string}

        embeds_one :basic_metabolic_panel, Demo.CDC.BasicMetabolicPanelEmbed
        embeds_many :metabolic_panels, Demo.CDC.MetabolicPanelEmbed
        embeds_many :medical_images, Demo.CDC.MedicalImageEmbed
        embeds_many :test_results, Demo.CDC.TestResultEmbed

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
    end
  end
