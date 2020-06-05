defmodule Demo.Votes.SurveyEmbed do
  use Ecto.Schema
  import Ecto.Changeset

  schema "survey_embeds" do
    field :title, :string
    field :respondent, :binary_id
    field :summary, :string
    field :discussion_site, :string
    field :opinion, :boolean #? yes(true) or no(false)

    timestamps()
  end

  @fields [
    :title, 
    :respondent, 
    :summary, 
    :discussion_site, 
    :opinion,
  ]
  @doc false
  def changeset(survey, attrs \\ %{}) do
    survey
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
