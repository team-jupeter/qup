defmodule Demo.Accounts do
  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.Accounts.User

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
  end

  def subscribe(user_id) do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{user_id}")
  end

  def list_users, do: Repo.all(User)

  def list_users(current_page, per_page) do 
    Repo.all(
      from u in User,
        order_by: [asc: u.id],
        offset: ^((current_page - 1) * per_page),
        limit: ^per_page
    )
  end

  def list_users_with_ids(ids) do
    Repo.all(from(u in User, where: u.id in ^ids))
  end

  def get_user(id), do: Repo.get(User, id)

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by(params), do: Repo.get_by(User, params)


  def authenticate_by_email_and_pass(email, given_pass) do
    user = get_user_by(email: email)

    cond do
      user && Pbkdf2.verify_pass(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end


  def create_user(attrs \\ %{}) do
    {:ok, user} = %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:user, :created])

    IO.inspect "attrs.family_code"
    IO.inspect attrs.family_code

    if attrs[:family_code] != nil do
      family = from f in Demo.Families.Family, where: f.family_code == ^attrs.family_code, select: f
      
      user
      |> User.family_changeset(family) 
      |> Repo.update
    end

    {:ok, user} 
  end

  
  def update_user(%User{} = user, attrs) do
    user
    |> User.update_changeset(attrs)
    |> Repo.update()
    |> notify_subscribers([:user, :updated])
  end


  def delete_user(%User{} = user) do
    user
    |> Repo.delete()
    |> notify_subscribers([:user, :deleted])
  end


  def change_user(user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def change_registration(%User{} = user, params) do
    User.registration_changeset(user, params)
  end

  def register_user(attrs \\ %{}) do 
    %User{}
    |> User.registration_changeset(attrs) 
    |> Repo.insert()
  end

  def update_entities(%User{} = user, entities) do
    user
    |> User.changeset_update_entities(entities)
    |> Repo.update!()
  end


  defp notify_subscribers({:ok, result}, event) do
    # IO.puts "notify_subscribers"
    # IO.inspect result
    # IO.inspect event
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic, {__MODULE__, event, result})
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic <> "#{result.id}", {__MODULE__, event, result})
    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _event), do: {:error, reason}
end
