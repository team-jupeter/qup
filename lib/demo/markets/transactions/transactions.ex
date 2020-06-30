defmodule Demo.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Transactions.Transaction

  def list_transactions do
    Repo.all(Transaction)
  end


  def get_transaction!(id), do: Repo.get!(Transaction, id)


  def create_transaction(invoice \\ %{}) do
    attrs = %{
      buyer: invoice.buyer.main_name,
      seller: invoice.seller.main_name,
      abc_input_id: invoice.buyer.main_id, #? in real transaction, it should be a public addresss of buyer.
      abc_input_name: invoice.buyer.main_name, 
      abc_output_id: invoice.seller.main_id,  #? in real transaction, it should be a public addresss of seller.
      abc_output_name: invoice.seller.main_name,  
      abc_amount: invoice.total,
      fiat_currency: invoice.fiat_currency
    }

    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:invoice, invoice)
    |> Repo.insert()
  end


  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end


  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  def change_transaction(%Transaction{} = transaction) do
    Transaction.changeset(transaction, %{})
  end
end
