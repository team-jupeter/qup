defmodule Demo.Repo.Migrations.CreateInitiatives do
  use Ecto.Migration

  def change do
    create table(:initiatives, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :initiators, {:array, :binary_id}
      add :num_of_initiators, :integer
      add :legal_review, :string

      add :type, :string
      add :lawyers, {:array, :binary_id}
      add :supports, :integer
      add :supporters, {:array, :binary_id}

      add :constitution_id, references(:constitutions, type: :uuid)
      add :law_id, references(:laws, type: :uuid)
      add :ordinance_id, references(:ordinances, type: :uuid)
      add :rule_id, references(:rules, type: :uuid)
  
      timestamps()
    end

  end
end
