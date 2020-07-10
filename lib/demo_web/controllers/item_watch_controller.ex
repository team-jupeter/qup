defmodule DemoWeb.ItemWatchController do
  use DemoWeb, :controller

  alias Demo.Multimedia 
  alias Demo.Business 

  def show(conn, %{"id" => id}) do 
    item = Business.get_product!(id)  
    conn = conn
    |> DemoWeb.ProductAuth.product_login(item)
    
    # IO.inspect conn

    # IO.inspect current_product
    video = Multimedia.get_product_video!(item, id) 
    # IO.puts "video"
    # IO.inspect video
    render(conn, "show.html", video: video, item: item)
  end
end
