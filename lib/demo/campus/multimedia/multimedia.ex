defmodule Demo.Multimedia do
  import Ecto.Query, warn: false

  alias Demo.Repo
  alias Demo.Multimedia.Video
  alias Demo.Multimedia.Category
  alias Demo.Accounts.User
  alias Demo.Business.Product

  def create_category!(name) do
    Repo.insert!(%Category{name: name}, on_conflict: :nothing)
  end
  
  def list_videos do
    Repo.all(Video)
  end

  def list_user_videos(%User{} = user) do
    Video
    |> user_videos_query(user)
    |> Repo.all()
  end

  def list_product_videos(%Product{} = product) do
    Video
    |> product_videos_query(product)
    |> Repo.all()
  end



  def get_user_video!(%User{} = user, id) do
    Video
    |> user_videos_query(user)
    |> Repo.get!(id)
  end 

  def get_product_video!(%Product{} = product, _id) do
    Video
    |> product_videos_query(product)
    |> Repo.one!()
  end 



  def get_video!(id), do: Repo.get!(Video, id)

  

  defp user_videos_query(query, %User{id: user_id}) do
    from(v in query, where: v.user_id == ^user_id)
  end

  defp product_videos_query(query, %Product{id: product_id}) do
    IO.inspect "product_id"
    IO.inspect product_id
    from(v in query, where: v.product_id == ^product_id)
  end



  def update_video(%Video{} = video, attrs) do
    video
    |> Video.changeset(attrs)
    |> Repo.update()
  end

  def delete_video(%Video{} = video) do
    Repo.delete(video)
  end 

  def create_video(%User{} = user, attrs \\ %{}) do
    %Video{}
    |> Video.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def change_video(%Video{} = video) do
    Video.changeset(video, %{})
  end

  alias Demo.Multimedia.Annotation

  def annotate_video(%User{id: user_id}, video_id, attrs) do 
    %Annotation{video_id: video_id, user_id: user_id}
    |> Annotation.changeset(attrs)
    |> Repo.insert()
  end

  def list_annotations(%Video{} = video, since_id \\ 0) do
    Repo.all(
      from a in Ecto.assoc(video, :annotations),
        where: a.id > ^since_id, 
        order_by: [asc: a.at, asc: a.id],
        limit: 500,
        preload: [:user]
    )
  end
end
