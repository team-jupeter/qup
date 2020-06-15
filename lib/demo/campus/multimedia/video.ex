defmodule Demo.Multimedia.Video do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    
    belongs_to :user, Demo.Accounts.User, type: :binary_id
    belongs_to :category, Demo.Multimedia.Category, type: :binary_id
    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description, :category_id])
    |> validate_required([:url, :title, :description])
  end
end
