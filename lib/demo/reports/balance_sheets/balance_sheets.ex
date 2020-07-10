defmodule Demo.BalanceSheets do
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.BalanceSheet
  alias Demo.Business.Entity

  def get_balance_sheet!(id), do: Repo.get!(BalanceSheet, id)

  def get_entity_balance_sheet!(entity_id) do
    BalanceSheet
    |> entity_balance_sheets_query(entity_id)
    |> Repo.all
  end

  defp entity_balance_sheets_query(query, entity_id) do    
    from(f in query, where: f.entity_id == ^entity_id)
  end

 
  def create_balance_sheet(attrs) do #? 사기업 
    %BalanceSheet{}
    |> BalanceSheet.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, attrs.entity)
    |> Ecto.Changeset.put_assoc(:supul, attrs.supul)
    |> Repo.insert()
  end

  def create_balance_sheet(%Entity{} = entity, attrs) do #? 사기업 
    %BalanceSheet{}
    |> BalanceSheet.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Ecto.Changeset.put_assoc(:supul, attrs.supul)
    |> Repo.insert()
  end
 
  def create_public_balance_sheet(attrs) do #? 공기업 또는 정부 기관
    %BalanceSheet{}
    |> BalanceSheet.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, attrs.entity)
    |> Ecto.Changeset.put_assoc(:nation_supul, attrs.nation_supul)
    |> Repo.insert()
  end
 
  def create_tax_balance_sheet(attrs \\ %{}) do #? 국세청 
    %BalanceSheet{}
    |> BalanceSheet.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:taxation, attrs.taxation)
    |> Ecto.Changeset.put_assoc(:nation_supul, attrs.nation_supul)
    |> Repo.insert()
  end
 
  def create_state_supul_balance_sheet(attrs \\ %{}) do
    %BalanceSheet{}
    |> BalanceSheet.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:state_supul, attrs.state_supul)
    |> Repo.insert()
  end

  def create_nation_supul_balance_sheet(attrs \\ %{}) do
    %BalanceSheet{}
    |> BalanceSheet.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:nation_supul, attrs.nation_supul)
    |> Repo.insert()
  end

  def create_supul_balance_sheet(attrs \\ %{}) do
    %BalanceSheet{}
    |> BalanceSheet.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:supul, attrs.supul)
    |> Repo.insert()
  end

  def add_t1s(%BalanceSheet{} = balance_sheet, attrs) do
    t1s = [attrs.t1s | balance_sheet.t1s]

    balance_sheet
    |> change
    |> Ecto.Changeset.put_embed(:t1s, t1s) 
    |> Repo.update!()
    |> update_gab_balance()
  end

  alias Demo.ABC.T1
  def renew_t1s(attrs, buyer, seller) do
    #? Find buyer's BS
    query = from b in BalanceSheet,
    where: b.entity_id == ^buyer.id

    buyer_BS = Repo.one(query)
    
    #? renew Buyer's BS T1
    t1_change = Decimal.sub(buyer_BS.gab_balance, attrs.amount)
    t1s = [%T1{
      # input: buyer_BS.t1s, #? if no input, output entity is same to input entity.
      output_id: buyer.id,
      output_name: buyer.name,
      amount: t1_change,
    }]

    buyer_BS
    |> change
    |> Ecto.Changeset.put_embed(:t1s, t1s) 
    |> Repo.update!()
    |> update_gab_balance()


   #? renew Seller's BS
   #? prepare t1 struct to pay.
    t1_payment = %{t1s: %T1{
      input_name: buyer.name,
      input_id: buyer.id,
      output_name: seller.name,
      output_id: seller.id,
      amount: attrs.amount,
    }}

    #? Find seller's BS
    query = from b in BalanceSheet,
    where: b.entity_id == ^seller.id

    seller_BS = Repo.one(query)
      
    add_t1s(seller_BS, t1_payment)
  end

  def update_gab_balance(bs) do
    amount_list = Enum.map(bs.t1s, fn item -> item.amount end) 
    gab_balance = Enum.reduce(amount_list, 0, fn amount, sum -> Decimal.add(amount, sum) end)
    update_balance_sheet(bs, %{gab_balance: gab_balance})
  end

  #? gopang_korea_BS = change(gopang_korea_BS) |> Ecto.Changeset.put_embed(:t1s, t1s) |> Repo.update!

  def update_balance_sheet(%BalanceSheet{} = balance_sheet, attrs) do
    BalanceSheet.changeset(balance_sheet, attrs) 
    |> Repo.update!()
  end

  def minus_gab_balance(%BalanceSheet{} = balance_sheet, %{amount: amount}) do
    minus_gab_balance = Decimal.sub(balance_sheet.gab_balance, amount)
    update_balance_sheet(balance_sheet, %{gab_balance: minus_gab_balance})
  end

  def plus_gab_balance(%BalanceSheet{} = balance_sheet, %{amount: amount}) do
    plus_gab_balance = Decimal.add(balance_sheet.gab_balance, amount)
    update_balance_sheet(balance_sheet, %{gab_balance: plus_gab_balance})
  end


  def change_balance_sheet(%BalanceSheet{} = balance_sheet) do
    BalanceSheet.changeset(balance_sheet, %{})
  end
  
'''
  def delete_balance_sheet(%BalanceSheet{} = balance_sheet) do
    Repo.delete(balance_sheet)
  end
'''
end
