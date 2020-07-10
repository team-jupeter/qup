defmodule DemoWeb.ProductWatchController do
  use DemoWeb, :controller

  alias Demo.Multimedia 
  alias Demo.Business

  def show(conn, %{"id" => id}) do
    current_product = Business.get_product!(id)  
    conn = conn
    |> DemoWeb.ProductAuth.product_login(current_product)
    
    # IO.inspect conn

    # IO.inspect current_product
    video = Multimedia.get_product_video!(current_product, id) 
    # IO.puts "video"
    # IO.inspect video
    render(conn, "show.html", video: video, product: current_product)
  end
end
