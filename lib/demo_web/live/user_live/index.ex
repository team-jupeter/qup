# defmodule DemoWeb.UserLive.Index do
#   use Phoenix.LiveView

#   alias Demo.Accounts
#   alias DemoWeb.UserLiveView
#   alias DemoWeb.Router.Helpers, as: Routes

#   def render(assigns), do: UserLiveView.render("index.html", assigns)

#   def mount(_params, _session, socket) do

#     if connected?(socket), do: Demo.Accounts.subscribe()
#     {:ok, assign(socket, page: 1, per_page: 5)}
#   end

#   def handle_params(params, _url, socket) do
#     {page, ""} = Integer.parse(params["page"] || "1")
#     {:noreply, socket |> assign(page: page) |> fetch()}
#   end

#   defp fetch(socket) do
#     %{page: page, per_page: per_page} = socket.assigns
#     users = Accounts.list_users(page, per_page)
#     assign(socket, users: users, page_title: "Listing Accounts – Page #{page}")
#   end

#   def handle_info({Accounts, [:user | _], _}, socket) do
#     {:noreply, fetch(socket)}
#   end

#   def handle_event("keydown", %{"code" => "ArrowLeft"}, socket) do
#     {:noreply, go_page(socket, socket.assigns.page - 1)}
#   end
#   def handle_event("keydown", %{"code" => "ArrowRight"}, socket) do
#     {:noreply, go_page(socket, socket.assigns.page + 1)}
#   end
#   def handle_event("keydown", _, socket), do: {:noreply, socket}

#   def handle_event("delete_user", %{"id" => id}, socket) do
#     # IO.puts "delete_user"

#     user = Accounts.get_user!(id)
#     {:ok, _user} = Accounts.delete_user(user)

#     {:noreply, socket}
#   end

#   defp go_page(socket, page) when page > 0 do
#     push_patch(socket, to: Routes.live_path(socket, __MODULE__, page))
#   end
#   defp go_page(socket, _page), do: socket

# end

# auto_load
defmodule DemoWeb.UserLive.Row do
  use Phoenix.LiveComponent

  defmodule Email do
    use Phoenix.LiveComponent

    def mount(socket) do
      IO.inspect socket

      {:ok, socket}
    end

    def render(assigns) do
      ~L"""
      <span id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>" phx-hook="Test">
        Email: <%= @email %>
      </span>
      """
    end
  end
  defmodule Nationality do
    use Phoenix.LiveComponent

    def mount(socket) do
      {:ok, socket}
    end

    def render(assigns) do
      ~L"""
      <span id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>" phx-hook="Test">
        Nationality: <%= @nationality %>
      </span>
      """
    end
  end
  defmodule Tax do
    use Phoenix.LiveComponent

    def mount(socket) do
      {:ok, socket}
    end

    def render(assigns) do
      ~L"""
      <span id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>" phx-hook="Test">
        Tax: <%= @tax_id %>
      </span>
      """
    end
  end
  defmodule Bank do
    use Phoenix.LiveComponent

    def mount(socket) do
      {:ok, socket}
    end

    def render(assigns) do
      ~L"""
      <span id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>" phx-hook="Test">
        Bank: <%= @bank_id %>
      </span>
      """
    end
  end

  defmodule Balance do
    use Phoenix.LiveComponent

    def mount(socket) do
      {:ok, socket}
    end

    def render(assigns) do
      ~L"""
      <span id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>" phx-hook="Test">
        Balance: <%= @balance %>
      </span>
      """
    end
  end

  defmodule Fingerprint do
    use Phoenix.LiveComponent

    def mount(socket) do
      {:ok, socket}
    end

    def render(assigns) do
      ~L"""
      <span id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>" phx-hook="Test">
        Fingerprint: <%= @fingerprint %>
      </span>
      """
    end
  end

  defmodule Face do
    use Phoenix.LiveComponent

    def mount(socket) do
      {:ok, socket}
    end

    def render(assigns) do
      ~L"""
      <span id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>" phx-hook="Test">
        Face: <%= @face %>
      </span>
      """
    end
  end

  defmodule Weight do
    use Phoenix.LiveComponent

    def mount(socket) do
      {:ok, socket}
    end

    def render(assigns) do
      ~L"""
      <span id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>" phx-hook="Test">
        Weight: <%= @weight %>
      </span>
      """
    end
  end

  defmodule Height do
    use Phoenix.LiveComponent

    def mount(socket) do
      {:ok, socket}
    end

    def render(assigns) do
      ~L"""
      <span id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>" phx-hook="Test">
        Height: <%= @height %>
      </span>
      """
    end
  end

  def mount(socket) do
    IO.puts "Row.mount"
    IO.inspect socket

    {:ok, socket}
  end

  def render(assigns) do
    IO.puts "Row.render"
    IO.inspect assigns

    ~L"""
    <tr class="user-row" id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>">
      <td><%= @user.id %></td>
      <td><%= @user.name %></td>
      <td>
        <%= live_component @socket, Email, id: "email-#{@id}", email: @user.email %>
      </td>
      <td>
        <%= live_component @socket, Nationality, id: "nationality-#{@id}", nationality: @user.nationality %>
      </td>
      <td>
        <%= live_component @socket, Tax, id: "tax-#{@id}", tax_id: @user.tax_id %>
      </td>
      <td>
        <%= live_component @socket, Bank, id: "bank-#{@id}", bank_id: @user.bank_id %>
      </td>
      <td>
        <%= live_component @socket, Balance, id: "balance-#{@id}", balance: @user.balance %>
      </td>
      <td>
        <%= live_component @socket, Fingerprint, id: "fingerprint-#{@id}", fingerprint: @user.fingerprint %>
      </td>
      <td>
        <%= live_component @socket, Face, id: "face-#{@id}", face: @user.face %>
      </td>
      <td>
        <%= live_component @socket, Weight, id: "weight-#{@id}", weight: @user.weight %>
      </td>
      <td>
        <%= live_component @socket, Height, id: "height-#{@id}", height: @user.height %>
      </td>
    </tr>
    """
  end

  # def handle_event("click", _, socket) do
  #   {:noreply, update(socket, :count, &(&1 + 1))}
  # end
end

defmodule DemoWeb.UserLive.Index do
  use Phoenix.LiveView

  alias DemoWeb.UserLive.Row

  def render(assigns) do
    IO.puts "render"
    IO.inspect assigns

    ~L"""
    <table>
      <tbody id="users"
             phx-update="append"
             phx-hook="InfiniteScroll"
             data-page="<%= @page %>">
        <%= for user <- @users do %>
          <%= live_component @socket, Row, id: "user-#{user.id}", user: user %>
        <% end %>
      </tbody>
    </table>
    """
  end

  def mount(_params, _session, socket) do
    IO.puts "index.mount"
    IO.inspect socket

    if connected?(socket), do: Demo.Accounts.subscribe()

    {:ok,
     socket
     |> assign(page: 1, per_page: 10)
     |> fetch(), temporary_assigns: [users: []]}
  end

  defp fetch(%{assigns: %{page: page, per_page: per}} = socket) do
    assign(socket, users: Demo.Accounts.list_users(page, per))
  end

  def handle_info({Accounts, [:user | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply, socket |> assign(page: assigns.page + 1) |> fetch()}
  end
end
