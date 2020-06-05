defmodule Demo.Votes.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "votes" do
    #? Constitution, Law, Order, Ordinance, Rules => supul, state_supul, nation_supul
    field :area, :string #? supul, state_supul, nation_supul
    field :type, :string #? new, update, delete
    field :vote_result, :string, default: "NOT PASSED" #? "passed", "not_passed"
    
    embeds_many :round_embeds, Demo.Votes.RoundEmbed
    embeds_many :surveys, Demo.Votes.SurveyEmbed
   
    belongs_to :constitution, Demo.Votes.Constitution
    belongs_to :law, Demo.Votes.Law
    belongs_to :ordinance, Demo.Votes.Ordinance
    belongs_to :rule, Demo.Votes.Rule

    timestamps()
  end
  @fields [
    :area, 
    :type, 
    :vote_result,
    :constitution_id,
    :law_id,
    :ordinance_id,
    :rule_id
  ]
  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
