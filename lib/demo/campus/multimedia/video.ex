defmodule Demo.Multimedia.Video do
  use Ecto.Schema
  import Ecto.Changeset
  
  @primary_key {:id, Demo.Multimedia.Permalink, autogenerate: true}
  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    field :slug,:string

    has_many :annotations, Demo.Multimedia.Annotation

    belongs_to :user, Demo.Accounts.User, type: :binary_id
    belongs_to :category, Demo.Multimedia.Category, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description, :category_id])
    |> validate_required([:url, :title, :description])
    |> assoc_constraint(:category)
    |> slugify_title()
  end


  defp slugify_title(changeset) do
    case fetch_change(changeset, :title) do
      {:ok, new_title} -> put_change(changeset, :slug, slugify(new_title))
      :error -> changeset
    end
  end

  defp slugify(str) do
    IO.inspect "str"
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end
end
