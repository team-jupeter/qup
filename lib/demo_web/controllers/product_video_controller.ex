defmodule DemoWeb.ProductVideoController do
  use DemoWeb, :controller

  alias Demo.Multimedia
  alias Demo.Multimedia.Video
  alias Demo.Products
  alias Demo.Entities

  plug DemoWeb.ProductAuth when action in [:new, :edit, :create]


  # def action(conn, _) do
  #   args = [conn, conn.params, conn.assigns.current_product]
  #   apply(__MODULE__, action_name(conn), args)
  # end

   
  # def index(conn, _params, current_product) do
  #   # conn = conn
  #   # |> DemoWeb.ProductAuth.product_login(current_product)
    

  #   # videos = Multimedia.list_product_videos(current_product) 
  #   # render(conn, "index.html", videos: videos)
  #   conn
  # end 

  def show(conn, %{"id" => id}) do
    current_product = Products.get_product!(id)
    
    conn = conn
    |> DemoWeb.ProductAuth.product_login(current_product)
    

    video = Multimedia.get_product_video!(current_product, id) 
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}, current_product) do

    video = Multimedia.get_product_video!(current_product, id) 
    changeset = Multimedia.change_video(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}, current_product) do
    video = Multimedia.get_product_video!(current_product, id) 

    case Multimedia.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: Routes.video_path(conn, :show, video))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_product) do
    video = Multimedia.get_product_video!(current_product, id) 
    {:ok, _video} = Multimedia.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: Routes.video_path(conn, :index))
  end

  def new(conn, _params, _current_product) do
    changeset = Multimedia.change_video(%Video{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}, current_product) do
    case Multimedia.create_video(current_product, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: Routes.video_path(conn, :show, video))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
