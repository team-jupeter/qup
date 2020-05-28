defmodule Demo.Patents.PatentApplication do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "patent_applications" do
    field :type, :string #? patent, design, trade mark...
    field :title, :string #? 
    field :applicants, {:array, :binary_id} #? entity.id
    field :inventor, {:array, :binary_id}
    field :description, :string      
    field :background_art, {:array, :string}      
    field :summary_of_invention, :string
    field :technical_problem, :string
    field :solution_to_problem, :string
    field :advantageous_effects_of_invention, :string
    field :brief_description_of_drawings, {:array, :string}      
    field :description_of_embodiments, :string
    field :examples, :string #? 실시예 
    field :industrial_applicability, :string
    field :reference_signs_list, {:array, :string}      
    field :reference_to_deposited_biological_material, :string
    field :sequence_listing_free_text, :string
    field :patent_literature, {:array, :string}      
    field :non_patent_literature, {:array, :string}      
    field :abstract, :string
    field :drawings, {:array, :string}  

    field :attached_docs_list, {:array, :string}
    field :attached_docs_hashes, {:array, :string}
    field :hash_of_attached_docs_hashes, :string

    embeds_many :claims, Demo.Patents.ClaimEmbed #? 청구항 

    timestamps()
  end

  @doc false
  def changeset(patent_application, attrs \\ %{}) do
    patent_application
    |> cast(attrs, [])
    |> validate_required([])
  end
end
