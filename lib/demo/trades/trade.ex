defmodule Demo.Trades.Trade do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "trades" do
    field :seller_entity_name, :string
    field :seller_entity_id, :string
    field :seller_supul_name, :string
    field :seller_supul_id, :string
    field :seller_nation_name, :string
    field :seller_nation_id, :string
    field :seller_taxation_name, :string
    field :seller_taxation_id, :string

    field :buyer_entity_name, :string
    field :buyer_entity_id, :string
    field :buyer_supul_name, :string
    field :buyer_supul_id, :string
    field :buyer_nation_name, :string
    field :buyer_nation_id, :string
    field :buyer_taxation_name, :string
    field :buyer_taxation_id, :string

    field :tax_amount, :decimal, precision: 15, scale: 2

    timestamps()
  end

  @fields [
    # :seller_entity_name,
    # :seller_entity_id,
    # :seller_supul_name,
    # :seller_taxation_name,
    # :seller_nation_name,
    # :tax_amount,
  ]

  @doc false
  def changeset(trade, attrs \\ %{}) do
    trade
    |> cast(attrs, @fields)
    |> validate_required([])
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
