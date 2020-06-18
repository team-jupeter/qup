defmodule Demo.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Business.Entity
  alias Demo.Accounts.User
  alias Demo.Schools.School
  alias Demo.Repo

  # @required_fields [:name, :email, :nationality]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :type, :string
    field :name, :string
    field :nationality, :string
    field :username, :string
    field :ssn, :string #? Social Security Number 
    field :email, :string # unique id of a human being
    field :birth_date, :naive_datetime
    field :password, :string, virtual: true
    field :password_hash, :string
    field :password_confirmation, :string, virtual: true


    field :nation_signature, :string
    
    # field :entity_names, {:array, :string}

    has_many :certificates, Demo.Certificates.Certificate
    has_one :health_report, Demo.CDC.HealthReport
    has_one :student, Demo.Schools.Student
    has_one :mentor, Demo.Schools.Mentor

    timestamps()

    belongs_to :nation, Demo.Nations.Nation, type: :binary_id #? 고국
    belongs_to :constitution,  Demo.Votes.Constitution, type: :binary_id #? 고향 
    belongs_to :supul,  Demo.Supuls.Supul, type: :binary_id #? 고향 
    
    many_to_many(
      :entities,
      Entity,
      join_through: "users_entities",
      on_replace: :delete
    )

    many_to_many(
      :schools,
      School,
      join_through: "schools_students",
      on_replace: :delete
    )
  end

  

  # @required_fields [:type, :name, :email]
  @fields [
    :name, :type, :nationality, :email, :birth_date, 
    :password, :nation_signature, :nation_id,
    :constitution_id, :supul_id
  ]

  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required([])
    |> validate_format(:email, ~r/@/)
  end

  def changeset_update_entities(%User{} = user, entities) do
    user 
    |> Repo.preload(:entities)
    |> change()  \
    |> put_assoc(:entities, entities) #? many to many between users and entities
    |> Repo.update!()
  end

  def registration_changeset(user, params) do
    user
    |> changeset(params)
    |> cast(params, [:email, :password])
    |> validate_required([:password])
    # |> cast_embed(:address) # error
    |> validate_length(:password, min: 5, max: 10)
    # |> unique_constraint([:email]) # error
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end

  # @phone ~r/^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/

  # @doc false
  # def changeset(user, attrs) do
  #   user
  #   |> cast(attrs, [:email, :email, :phone_number, :password])
    # |> validate_required([:email, :email, :phone_number])
    # |> validate_confirmation(:password)
    # |> validate_format(:email, ~r/^[a-zA-Z0-9_]*$/,
    #   message: "only letters, numbers, and underscores please"
    # )
    # |> validate_length(:email, max: 12)
    # |> validate_format(:email, ~r/.+@.+/, message: "must be a valid email address")
    # |> validate_format(:phone_number, @phone, message: "must be a valid number")
    # |> unique_constraint(:email)
  # end



  # defmodule PasswordManager do
  #   alias Ecto.Multi

  #   def reset(account, params) do
  #     Multi.new()
  #     |> Multi.update(:account, Account.password_reset_changeset(account, params))
  #     |> Multi.insert(:log, Log.password_reset_changeset(account, params))
  #     |> Multi.delete_all(:sessions, Ecto.assoc(account, :sessions))
  #   end
  # end
end
