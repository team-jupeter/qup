defmodule Demo.Repo.Migrations.CreateOpenhashes do
  use Ecto.Migration

  def change do
    create table(:openhashes) do
      add :type, :string #? 씨줄 seejule, 날줄 naljule 

      add :buyer_id, :binary_id
      add :buyer_name, :string
      add :seller_id, :binary_id
      add :seller_name, :string
  
      add :input, :binary_id #? 씨줄 => the receiving supul, 날줄 => the sending supul
      add :input_name, :string
      add :output, :binary_id #? always the receiving supul
      add :output_name, :string
  
      add :payload_hash, :string
      add :chained_hash, :string, default: "origin"
  
      timestamps() 
    end

  end
end
