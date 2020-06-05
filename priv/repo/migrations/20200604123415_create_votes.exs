defmodule Demo.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :area, :string 
      add :type, :string 
      add :vote_result, :string, default: "NOT PASSED"

      add(:round_embeds, {:array, :jsonb}, default: [])
      add(:survey_embeds, {:array, :jsonb}, default: [])

      add :constitution_id, references(:constitutions, type: :uuid)
      add :law_id, references(:laws, type: :uuid)
      add :ordinance_id, references(:ordinances, type: :uuid)
      add :rule_id, references(:rules, type: :uuid)

      timestamps()
    end

  end
end
