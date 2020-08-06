defmodule Demo.T4Lists.T4List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "t4_lists" do
    field :BSE, :string
    field :DB, :string
    field :ENX, :string
    field :JPX, :string
    field :KRX, :string
    field :LSE, :string
    field :NASDAQ, :string
    field :NSE, :string
    field :NYSE, :string
    field :SEHK, :string
    field :SIX, :string
    field :SSE, :string
    field :SZSE, :string
    field :TSX, :string

    timestamps()
  end

  @doc false
  def changeset(t4_list, attrs) do
    t4_list
    |> cast(attrs, [:NYSE, :NASDAQ, :JPX, :LSE, :SSE, :SEHK, :ENX, :SZSE, :TSX, :BSE, :NSE, :DB, :SIX, :KRX])
    |> validate_required([:NYSE, :NASDAQ, :JPX, :LSE, :SSE, :SEHK, :ENX, :SZSE, :TSX, :BSE, :NSE, :DB, :SIX, :KRX])
  end
end
