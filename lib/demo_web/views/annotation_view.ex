defmodule DemoWeb.AnnotationView do
  use DemoWeb, :view

  def render("annotation.json", %{annotation: annotation}) do
    %{
      id: annotation.id,
      body: annotation.body,
      at: annotation.at,
      user: render_one(annotation.user, DemoWeb.UserView, "user.json")
    }
  end
end
