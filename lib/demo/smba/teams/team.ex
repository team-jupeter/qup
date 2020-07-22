defmodule Demo.Accounts.Team do
  import Ecto.Changeset
  use Ecto.Schema
  alias Demo.Accounts.{MemberEmbed, ProjectEmbed}

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "teams" do
    field :name, :string
    field :date_started, :integer
    field :date_ended, :integer

    embeds_many :member_embeds, MemberEmbed, on_replace: :delete
    embeds_many :project_embeds, ProjectEmbed, on_replace: :delete

    # has_many :users, Demo.Accounts.User
    belongs_to :entity, Demo.Entities.Entity

  end

  def changeset(team, params) do
    team
    |> cast(params, [:name, :date_started, :date_ended])
    |> validate_required([:name, :date_started])
    # custom validation
    # |> validate_date_order(:date_started, :date_ended)
  end
end

