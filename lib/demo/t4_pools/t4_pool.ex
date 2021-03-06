defmodule Demo.T4Pools.T4Pool do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "t4_pools" do
    field :name, :string

    field :bse, :decimal, precision: 12, scale: 4, default: 0.0 #? Bombay Stock Exchange
    field :db, :decimal, precision: 12, scale: 4, default: 0.0 #? Deutsche Börse
    field :ens, :decimal, precision: 12, scale: 4, default: 0.0 #? Euronext
    field :jpx, :decimal, precision: 12, scale: 4, default: 0.0 #? Japan Exchange Group
    field :krx, :decimal, precision: 12, scale: 4, default: 0.0 #? Korea Exchange
    field :lse, :decimal, precision: 12, scale: 4, default: 0.0 #? London Stock Exchange
    field :nasdaq, :decimal, precision: 12, scale: 4, default: 0.0 #? Nasdaq
    field :nse, :decimal, precision: 12, scale: 4, default: 0.0 #? National Stock Exchange
    field :nyse, :decimal, precision: 12, scale: 4, default: 0.0 #? New York Stock Exchange
    field :sehk, :decimal, precision: 12, scale: 4, default: 0.0 #? Hong Kong Stock Exchange
    field :six, :decimal, precision: 12, scale: 4, default: 0.0 #? SIX Swiss Exchange
    field :sse, :decimal, precision: 12, scale: 4, default: 0.0 #? Shanghai Stock Exchange
    field :szse, :decimal, precision: 12, scale: 4, default: 0.0 #? Shenzhen Stock Exchange
    field :tsx, :decimal, precision: 12, scale: 4, default: 0.0 #? Toronto Stock Exchange

    belongs_to :gab, Demo.Gabs.Gab, type: :binary_id
    belongs_to :balance_sheet, Demo.BalanceSheets.BalanceSheet, type: :binary_id

    timestamps()
  end

  @fields [
     :name,
     :bse, 
     :db, 
     :ens, 
     :jpx, 
     :krx, 
     :lse, 
     :nasdaq, 
     :nse, 
     :nyse, 
     :sehk, 
     :six, 
     :sse, 
     :szse, 
     :tsx, 
  ]
  @doc false
  def changeset(t4_pool, attrs) do
    t4_pool
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
