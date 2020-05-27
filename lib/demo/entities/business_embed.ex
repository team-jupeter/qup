defmodule Demo.Entities.BusinessEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :name, :string #? Company Name
    field :crn, :string #? Company Registration Number
    field :sic_code, :string #? Standard Industrial Classification
    field :legal_status, :string #? Corporation, Foundation, NGO ...
    field :year_started, :integer
    field :year_ended, :integer
    field :addresses, {:array, :map} #? office, factory, lab ...
    field :employees, {:array, :map} #? user_ids
    field :products, {:array, :map} #? Global Products Classification
    field :yearly_sales, :decimal, default: 0.0
    field :num_of_shares, {:array, :map}
    field :share_price, {:array, :map}
    field :accrued_tax_payment, :decimal, default: 0.0
    field :credit_rate, :string #? AAA, ..., FFF => 24 rates
    field :credit_rate_of_members, {:array, :map} #? AAA, ..., FFF => 24 rates
    
    field :locked, :boolean, default: false
  end

  @fields [
    :name, :crn, :sic_code, :legal_status, :year_started, 
    :addresses, :employees, :products, :yearly_sales, :num_of_shares,
    :share_price, :accrued_tax_payment, :credit_rate, :credit_rate_of_members
  ]
  @required [:name, :crn, :sic_code, :legal_status, :year_started, :num_of_shares]

  def changeset(buyer_embed, params) do
    buyer_embed
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
