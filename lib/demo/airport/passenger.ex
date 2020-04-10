defmodule Demo.Airport.Passenger do
  use Ecto.Schema
  import Ecto.Changeset
  # alias Demo.Trade.Transaction

  @required_fields [:name]

  schema "passengers" do
    field :name, :string
    field :email, :string

    field :airline, :string # unique id of a human being
    field :departure_airport, :string
    field :arrival_airport, :string
    field :boarding_time, :date
    field :boarding_gate, :date
    field :boarding_door, :date

    # Assume to use Samsung s2+ smartphone
    field :scanned_fingerprint, :string
    field :scanned_face, :string
    field :scanned_weight, :string
    field :scanned_height, :string
    # field :interpol, :string

    field :check_fingerprint, :boolean, default: false
    field :check_face, :boolean, default: false
    field :check_weight, :boolean, default: false
    field :check_height, :boolean, default: false
    # field :check_interpol, :boolean, default: false

    belongs_to :airport, Demo.Airport
    # has_one :users, Demo.Accounts.User

    timestamps()

  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
  end

  def ticket_changeset(user, attrs) do
    user
    |> cast(attrs, [:airline, :departure_airport, :arrival_airport, :boarding_time, :boarding_gate, :boarding_door])
    |> validate_required([:airline, :departure_airport, :arrival_airport, :boarding_time, :boarding_gate, :boarding_door])
    # |> validate_format(:boarding_time)
  end

  # @scanned_bio_data [:scanned_fingerprint, :scanned_face, :scanned_weight, :scanned_height]
  # def scanned_changeset(passsenger, attrs) do
  #   passsenger
  #   |> cast(attrs, @scanned_bio_data)
  #   |> validate_bio_data(@scanned_bio_data)
  #   |> validate_interpol()
  # end

  # def validate_bio_data(passenger, @scanned_bio_data) do
  #   for i <- @scanned_bio_data do
  #     if i == "last_" <> "#{i}" do
  #       i = "last_" <> "#{i}"
  #       passenger.check_ <> "#{i}"
  #     else
  #       # add_error(changeset, passenger.check_ <> "#{i}", "does not match")
  #     end
  #   end
  # end
  # def validate_interpol(changeset) do
  #   # write interpol process
  #   changeset
  # end



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


  def changeset_update_transactions(user, transactions) do
    user
    |> cast(%{}, @required_fields)
    # associate transactions to the user
    |> put_assoc(:transactions, transactions)
  end

end
