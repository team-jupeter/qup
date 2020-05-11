defmodule Demo.Trades.Trade do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trades" do

    belongs_to :invoice, Demo.Invoices.Invoice
    belongs_to :supul, Demo.Supuls.Supul
    belongs_to :taxation, Demo.Taxations.Taxation

    timestamps()
  end

  @doc false
  def changeset(trade, attrs) do
    trade
    |> cast(attrs, [:taxation, :supul])
    |> validate_required([:taxation])
  end


  # def create(params) do
  #   IO.puts "create"
  #   changeset(%Trade{}, params)
  #   |> get_entities(params)
  #   |> put_assoc(:entities, get_entities(params))
  #   # |> put_assoc(:entities, Entity.changeset(params[:buyer]))
  #   |> IO.inspect
  #   |> Repo.insert
  # end

  # defp get_entities(params) do
  #   IO.puts "get_entities"
  #   IO.inspect params

  #   entities = entities_with_supuls(params[:entities] || params["invoice_entities"])

  #   IO.inspect "entities"
  #   IO.inspect entities

  #   IO.puts "return invoice_entities"
  #   Enum.map(entities, fn(entity)-> Invoiceentity.changeset(%Invoiceentity{}, entity) end)
  # end


  # defp entities_with_supuls(entities) do
  #   IO.puts "entities_with_supuls"

  #   entity_ids = Enum.map(entities, fn(entity) -> entity[:entity_id] || entity["entity_id"] end)

  #   # q = from("entities", where: id: in ^entity_ids, select: [:id, :supul])
  #   q = from(i in entity, select: %{id: i.id, supul: i.supul}, where: i.id in ^entity_ids)

  #   supuls = Repo.all(q)

  #   IO.puts "show entity_id and supuls"
  #   IO.inspect supuls

  #   IO.puts "return entity_id, quantity, and supuls"
  #   Enum.map(entities, fn(entity) ->
  #     entity_id = entity[:entity_id] || entity["entity_id"]
  #     a = %{
  #        entity_id: entity_id,
  #        quantity: entity[:quantity] || entity["quantity"],
  #        supul: Enum.find(supuls, fn(p) -> p[:id] == entity_id end)[:supul] || 0
  #      }
  #     IO.puts "a"
  #     IO.inspect a
  #     a
  #   end)
  # end

  # defp validate_entity_count(cs, params) do
  #   entities = params[:invoice_entities] || params["invoice_entities"]

  #   if Enum.count(entities) <= 0 do
  #     add_error(cs, :invoice_entities, "Invalid number of entities")
  #   else
  #     cs
  #   end
  # end
end
