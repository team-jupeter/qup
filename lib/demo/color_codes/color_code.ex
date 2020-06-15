defmodule Demo.ColorCodes.ColorCode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "color_codes" do
    # aqua black blue fuchsia gray green lime maroon navy purple red silver teal olive white yellow
    # 1 ~ 12
    # 7^9 = 40,353,607
    # red, orange, yellow, green, blue, indigo, violet
    field :char_1, :integer
    field :char_2, :integer
    field :char_3, :integer

    field :char_4, :integer
    field :char_5, :integer
    field :char_6, :integer

    field :char_7, :integer
    field :char_8, :integer
    field :char_9, :integer

    belongs_to :entity, Demo.Accounts.Entity

    timestamps()
  end

  @doc false
  def changeset(color_code, attrs) do
    color_code
    |> cast(attrs, [:char_1, :char_2, :char_3, :char_4, :char_5, :char_6, :char_7, :char_8, :char_9])
    |> validate_required([:char_1, :char_2])
  end
end
