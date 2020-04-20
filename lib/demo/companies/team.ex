defmodule Demo.Companies.Team do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :name, :string
    field :year_started, :integer
    field :year_ended, :integer

    has_many :users, Demo.Accounts.User
    belongs_to :company, Demo.Companies.Company

  end

  def changeset(team, params) do
    team
    |> cast(params, [:name, :year_started, :year_ended])
    |> validate_required([:name, :year_started])
    # custom validation
    # |> validate_year_order(:year_started, :year_ended)
  end
end

