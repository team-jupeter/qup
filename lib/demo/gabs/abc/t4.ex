defmodule Demo.ABC.T4 do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.ABC.T4
   
  embedded_schema do 
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

    
    #? locking script and conditions of spending moneny by recipient.
    embeds_one :abc_locker, Demo.ABC.ABCLockerEmbed

  end

  @fields [
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
 def changeset(t4, attrs) do
   t4
   |> cast(attrs, @fields)
   |> validate_required([])
 end

  def merge_changeset(%T4{} = t4, params) do
    t4
    |> cast(Map.keys(params), @fields)
    |> validate_required([])
  end
end
 