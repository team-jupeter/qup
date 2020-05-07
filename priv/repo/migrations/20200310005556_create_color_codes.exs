defmodule Demo.Repo.Migrations.CreateColorCodes do
  use Ecto.Migration

  def change do
    create table(:color_codes, primary_key: false) do
      add :id, :uuid, primary_key: true
      # aqua black blue fuchsia gray green lime maroon navy purple red silver teal olive white yellow
      add :char_1, :string
      add :char_2, :string
      add :char_3, :string

      add :char_4, :string
      add :char_5, :string
      add :char_6, :string

      add :char_7, :string
      add :char_8, :string
      add :char_9, :string

      timestamps()
    end

  end
end
