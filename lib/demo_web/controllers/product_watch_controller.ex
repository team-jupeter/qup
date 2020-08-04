defmodule DemoWeb.ProductWatchController do
  use DemoWeb, :controller

  alias Demo.Multimedia 
  alias Demo.Products

  def show(conn, %{"id" => id}) do
    current_product = Products.get_product!(id)  
    conn = conn
    |> DemoWeb.ProductAuth.product_login(current_product)
    
    video = Multimedia.get_product_video!(current_product, id) 
    render(conn, "show.html", video: video, product: current_product)
  end
end
