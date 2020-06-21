defmodule DemoWeb.VideoChannel do
    use DemoWeb, :channel
  
    alias Demo.{Accounts, Multimedia}
  
    def join("videos:" <> video_id, _params, socket) do
      {:ok, assign(socket, :video_id, String.to_integer(video_id))}
    end
  
    def handle_in(event, params, socket) do 
      user = Accounts.get_user!(socket.assigns.user_id)
      handle_in(event, params, user, socket)
    end
  
    def handle_in("new_annotation", params, user, socket) do 
      case Multimedia.annotate_video(user, socket.assigns.video_id, params) do
        {:ok, annotation} ->
          broadcast!(socket, "new_annotation", %{
            id: annotation.id,
            user: DemoWeb.UserView.render("user.json", %{user: user}), 
            body: annotation.body,
            at: annotation.at
          })
          {:reply, :ok, socket}
  
        {:error, changeset} ->
          {:reply, {:error, %{errors: changeset}}, socket}
      end
    end
  end