defmodule DemoWeb.ItemWatchController do
  use DemoWeb, :controller

  alias Demo.Multimedia 
  # alias Demo.Entities 
  alias Demo.Products 

  def show(conn, %{"id" => id}) do 
    item = Products.get_product!(id)  
    conn = conn
    |> DemoWeb.ProductAuth.product_login(item)
    
    video = Multimedia.get_product_video!(item, id) 
    render(conn, "show.html", video: video, item: item)
  end
end
