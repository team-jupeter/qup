defmodule DemoWeb.ProductWatchController do
  use DemoWeb, :controller

  alias Demo.Multimedia

  def show(conn, %{"id" => id}) do
    video = Multimedia.get_video!(id)
    render(conn, "show.html", video: video)
  end
end
