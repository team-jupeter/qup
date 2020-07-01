defmodule Demo.Supuls do
  @moduledoc """
  The Supuls context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Supuls.Supul

  def list_supuls do
    Repo.all(Supul)
  end

  def get_supul!(id), do: Repo.get!(Supul, id)

  def create_supul(attrs \\ %{}) do
    %Supul{}
    |> Supul.changeset(attrs)
    |> Repo.insert()
  end

  def update_supul(%Supul{} = supul, attrs) do
    supul
    |> Supul.changeset(attrs)
    |> Repo.update()
  end

  def delete_supul(%Supul{} = supul) do
    Repo.delete(supul)
  end


  def change_supul(%Supul{} = supul) do
    Supul.changeset(supul, %{})
  end

  import Ecto.Query, only: [from: 2]
  alias Demo.IncomeStatements
  alias Demo.BalanceSheets
  alias Demo.IncomeStatements
  alias Demo.Reports.IncomeStatement
  alias Demo.Business
  alias Demo.Business.Entity

  def process_transaction(transaction) do
    #? Update IS of buyer.
    buyer_id = transaction.invoice.buyer.main_id
    query = from i in IncomeStatement,
    where: i.entity_id == ^buyer_id
    
    buyer_IS = Repo.one(query)
    IncomeStatements.add_expense(buyer_IS, %{amount: transaction.abc_amount})
    
    #? Update IS of seller.
    seller_id = transaction.invoice.seller.main_id
    query = from i in IncomeStatement,
    where: i.entity_id == ^seller_id
    
    seller_IS = Repo.one(query)
    IncomeStatements.add_revenue(seller_IS, %{amount: transaction.abc_amount})
    



    #? Update t1s and gab_balance of both buyer and seller.
    #? Buyer gab_balance
    query = from b in Entity,
    where: b.id == ^buyer_id

    buyer = Repo.one(query)
    Business.minus_gab_balance(buyer, %{amount: transaction.abc_amount}) 
    
    #? Seller gab_balance
    query = from s in Entity,
    where: s.id == ^seller_id

    seller = Repo.one(query)
    Business.plus_gab_balance(seller, %{amount: transaction.abc_amount}) 
  

    #? after
    BalanceSheets.renew_t1s(%{amount: transaction.abc_amount}, buyer, seller)  

    
    #? before
    # query = from b in BalanceSheet,
    # where: b.entity_id == ^buyer_id

    # buyer_BS = Repo.one(query)
    # BalanceSheets.minus_gab_balance(buyer_BS, %{amount: transaction.abc_amount})
  
    ## Update BS of seller.
    # query = from b in BalanceSheet,
    #       where: b.entity_id == ^seller_id

    # seller_BS = Repo.one(query)

    # BalanceSheets.plus_gab_balance(seller_BS, %{amount: transaction.abc_amount})
  end
end
