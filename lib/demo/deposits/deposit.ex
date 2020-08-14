defmodule Demo.Deposits.Deposit do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "deposits" do
    field :input_name, :string
    field :input_email, :string
    field :input_tel, :string
    field :input_id, :binary_id
    field :input_currency, :string
    field :input_bank, :string
    field :input_bank_account, :string
    field :input_amount, :decimal, precision: 12, scale: 2, default: 0.0
    
    field :output_name, :string
    field :output_id, :binary_id
    field :output_email, :string
    field :output_tel, :string
    field :output_currency, :string
    field :output_amount, :decimal, precision: 12, scale: 2, default: 0.0

    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    belongs_to :gab_account, Demo.GabAccounts.GabAccount, type: :binary_id

    timestamps()
  end

  @fields [
    :input_name, 
    :input_id,
    :input_email, 
    :input_tel, 
    :input_currency, 
    :input_bank,
    :input_bank_account,
    :input_amount, 
    
    :output_name, 
    :output_id,
    :output_email, 
    :output_tel, 
    :output_currency, 
    :output_amount, 
  ]
  @doc false
  def changeset(deposit, attrs) do
    deposit
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
