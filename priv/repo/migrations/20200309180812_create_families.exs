defmodule Demo.Repo.Migrations.CreateFamilies do
  use Ecto.Migration

  def change do
    create table(:families, primary_key: false) do
      # ? add charater "f" to the email of the house holder.
      add :id, :uuid, primary_key: true
      add :gab_balance, :decimal, default: 0.0
      add(:family_code, :string)
      add(:nationality, :string)
      add(:auth_code, :string)
      add(:address, :string)

      # ? the name of the house_holder
      add(:house_holder_name, :string)
      # ? the email of the house_holder
      add(:house_holder_email, :string)
      add(:house_holder_supul_id, :string)

      # ? family members' titles are relative to the house holder
      # ? the value of each add is his/her name. 
      add(:grand_father_name, :string)
      add(:grand_mother_name, :string)
      add(:grand_father_in_law_name, :string)
      add(:grand_mother_in_law_name, :string)
      add(:father_name, :string)
      add(:mother_name, :string)
      add(:father_in_law_name, :string)
      add(:mother_in_law_name, :string)
      add(:husband_id, :binary_id)
      add(:husband_name, :string)
      add(:wife_id, :binary_id)
      add(:wife_name, :string)
      add(:sons, {:array, :map})
      add(:dauthers, {:array, :map})
      add(:grand_sons, {:array, :map})
      add(:grand_dauthers, {:array, :map})
      add(:relatives, {:array, :map})
      add(:inmates, {:array, :map})

      add(:grand_father_email, :string)
      add(:grand_mother_email, :string)
      add(:grand_father_in_law_email, :string)
      add(:grand_mother_in_law_email, :string)
      add(:father_email, :string)
      add(:mother_email, :string)
      add(:father_in_law_email, :string)
      add(:mother_in_law_email, :string)
      add(:husband_email, :string)
      add(:wife_email, :string)

      add(:entity_id_of_grand_father, :string)
      add(:entity_id_of_grand_mother, :string)
      add(:entity_id_of_grand_father_in_law, :string)
      add(:entity_id_of_grand_mother_in_law, :string)
      add(:entity_id_of_father, :string)
      add(:entity_id_of_mother, :string)
      add(:entity_id_of_father_in_law, :string)
      add(:entity_id_of_mother_in_law, :string)
      add(:entity_id_of_house_holder, :string)
      add(:entity_id_of_husband, :string)
      add(:entity_id_of_wife, :string)
      add(:entity_id_of_sons, {:array, :map})
      add(:entity_id_of_dauthers, {:array, :map})
      add(:entity_id_of_grand_sons, {:array, :map})
      add(:entity_id_of_grand_dauthers, {:array, :map})
      add(:entity_id_of_relatives, {:array, :map})
      add(:entity_id_of_inmates, {:array, :map})
      add :openhash_id, :binary_id
      add :payload, :text

      add(:nation_id, references(:nations, type: :uuid))
      add(:supul_id, references(:supuls, type: :uuid))
      
      timestamps()
    end
  end
end
