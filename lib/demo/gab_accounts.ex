defmodule Demo.GabAccounts do
  @moduledoc """
  The GabAccounts context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.GabAccounts.GabAccount

  def list_gab_accounts do
    Repo.all(GabAccount)
  end

  def get_gab_account!(id), do: Repo.get!(GabAccount, id)

  def get_entity_gab_account(entity_id) do
    GabAccount
    |> entity_gab_account_query(entity_id)
    |> Repo.one()
  end

  defp entity_gab_account_query(query, entity_id) do
    from(f in query, where: f.entity_id == ^entity_id)
  end

  def create_gab_account(attrs \\ %{}) do
    %GabAccount{}
    |> GabAccount.changeset(attrs)
    |> Repo.insert()
  end

  def update_gab_account(%GabAccount{} = gab_account, attrs) do
    gab_account
    |> GabAccount.changeset(attrs)
    |> Repo.update()
  end

  def delete_gab_account(%GabAccount{} = gab_account) do
    Repo.delete(gab_account)
  end

  def change_gab_account(%GabAccount{} = gab_account) do
    GabAccount.changeset(gab_account, %{})
  end

  alias Demo.ABC.T1

  def renew_ts(attrs, buyer, seller) do
    # ? Find buyer's BS
    query =
      from g in GabAccount,
        where: g.entity_id == ^buyer.id

    buyer_GA = Repo.one(query)

    # ? renew Buyer's BS T1
    t_change = Decimal.sub(buyer_GA.t1, attrs.amount)

    IO.inspect "t_change"
    IO.inspect t_change

    attrs = %{
      gab_balance: t_change,
      ts: %T1{
        input_name: buyer.name,
        output_name: seller.name,
        amount: attrs.amount
      }
    }

    add_ts(buyer_GA, attrs)

    # ? Find seller's GA
    query =
      from b in GabAccount,
        where: b.entity_id == ^seller.id

    seller_GA = Repo.one(query)

    add_ts(seller_GA, attrs)
  end

  def add_ts(%GabAccount{} = gab_account, attrs) do
    ts = [attrs.ts | gab_account.ts]
    
    gab_account
    |> GabAccount.changeset()
    |> Ecto.Changeset.put_embed(:ts, ts)
    |> Repo.update!()
  end
end
