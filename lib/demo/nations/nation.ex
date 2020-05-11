# 한국, 일본, 중국, 미국 ...
defmodule Demo.Nations.Nation do
  use Ecto.Schema
  alias Demo.Repo
  import Ecto.Changeset
  alias Demo.Nations.Nation

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "nations" do
    field :name, :string

    has_one :bank,  Demo.Banks.Bank, on_replace: :nilify
    has_one :taxation,  Demo.Taxations.Taxation, on_replace: :nilify
    has_many :entities, Demo.Entities.Entity, on_replace: :nilify
    has_many :users, Demo.Users.User, on_replace: :nilify
  end

  def changeset(%Nation{} = nation, attrs) do
    nation
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def create(params) do
    changeset(%Nation{}, params)
    |> put_assoc(:users, params[:nation_id])
    |> Repo.insert
  end
end
