defmodule Demo.Repo.Migrations.CreatePatentApplications do
  use Ecto.Migration

  def change do
    create table(:patent_applications, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :title, :string
      add :applicants, {:array, :binary_id}
      add :inventor, {:array, :binary_id}
      add :description, :string
      add :background_art, {:array, :string}
      add :summary_of_invention, :string
      add :technical_problem, :string
      add :solution_to_problem, :string
      add :advantageous_effects_of_invention, :string
      add :brief_description_of_drawings, {:array, :string}      
      add :description_of_embodiments, :string
      add :examples, :string
      add :industrial_applicability, :string
      add :reference_signs_list, {:array, :string}
      add :reference_to_deposited_biological_material, :string
      add :sequence_listing_free_text, :string
      add :patent_literature, {:array, :string}
      add :non_patent_literature, {:array, :string}
      add :claims, {:array, :string}
      add :abstract, :string
      add :drawings, {:array, :string}

      add :attached_docs_list, {:array, :string}
      add :attached_docs_hashes, {:array, :string}
      add :hash_of_attached_docs_hashes, :string

      timestamps()
    end

  end
end
