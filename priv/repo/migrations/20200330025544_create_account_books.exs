defmodule Demo.Repo.Migrations.CreateAccountBooks do
  use Ecto.Migration

  def change do
    create table(:account_books, primary_key: false) do
      add :id, :uuid, primary_key: true

      #? 00.Temporoary Accounts for test
      add :revenue, :decimal, precision: 12, scale: 2, default: 1000.0
      add :expense, :decimal, precision: 12, scale: 2, default: 0.0

      #? 01.식료품 · 비주류음료
      add :grain, :decimal, precision: 12, scale: 2, default: 0.0
      add :grain_products, :decimal, precision: 12, scale: 2, default: 0.0
      add :bread_and_rice, :decimal, precision: 12, scale: 2, default: 0.0
      add :meat, :decimal, precision: 12, scale: 2, default: 0.0
      add :meat_products, :decimal, precision: 12, scale: 2, default: 0.0
      add :fresh_fish, :decimal, precision: 12, scale: 2, default: 0.0
      add :salt_and_salt_marine_animals, :decimal, precision: 12, scale: 2, default: 0.0
      add :other_aquatic_animal_processing, :decimal, precision: 12, scale: 2, default: 0.0
      add :dairy_products_and_eggs, :decimal, precision: 12, scale: 2, default: 0.0
      add :oil_and_fat, :decimal, precision: 12, scale: 2, default: 0.0
      add :fruit_and_fruit_processed_products, :decimal, precision: 12, scale: 2, default: 0.0

      add :vegetable_and_vegetable_processed_products, :decimal,
        precision: 12,
        scale: 2,
        default: 0.0

      add :seaweed_and_seaweed_processed_products, :decimal,
        precision: 12,
        scale: 2,
        default: 0.0

      add :sugars_and_sweets, :decimal, precision: 12, scale: 2, default: 0.0
      add :seasoned_food, :decimal, precision: 12, scale: 2, default: 0.0
      add :other_food, :decimal, precision: 12, scale: 2, default: 0.0
      add :coffee_and_tea, :decimal, precision: 12, scale: 2, default: 0.0
      add :juice_and_other_drinks, :decimal, precision: 12, scale: 2, default: 0.0

      # ? 02.Liquor_and_tobacco
      add :liquor, :decimal, precision: 12, scale: 2, default: 0.0
      add :cigarette, :decimal, precision: 12, scale: 2, default: 0.0

      # ? 03.Clothing · Shoes
      add :fabric_and_others, :decimal, precision: 12, scale: 2, default: 0.0
      add :undergarment, :decimal, precision: 12, scale: 2, default: 0.0
      add :other_apparel, :decimal, precision: 12, scale: 2, default: 0.0
      add :clothing_related_services, :decimal, precision: 12, scale: 2, default: 0.0
      add :shoes, :decimal, precision: 12, scale: 2, default: 0.0
      add :footwear_service, :decimal, precision: 12, scale: 2, default: 0.0

      # ?04.Housing, water supply, light heat
      add :actual_residential_cost, :decimal, precision: 12, scale: 2, default: 0.0
      add :housing_maintenance_and_repair, :decimal, precision: 12, scale: 2, default: 0.0
      add :water_and_sewage_and_waste_treatment, :decimal, precision: 12, scale: 2, default: 0.0
      add :other_residential_services, :decimal, precision: 12, scale: 2, default: 0.0
      add :fuel_costs, :decimal, precision: 12, scale: 2, default: 0.0

      # ?05. household goods_and_housework service
      add :furniture_and_lighting, :decimal, precision: 12, scale: 2, default: 0.0
      add :interior_decoration, :decimal, precision: 12, scale: 2, default: 0.0

      add :furniture_lighting_and_decoration_services, :decimal,
        precision: 12,
        scale: 2,
        default: 0.0

      add :household_textile, :decimal, precision: 12, scale: 2, default: 0.0

      add :household_appliances_and_household_appliances, :decimal,
        precision: 12,
        scale: 2,
        default: 0.0

      add :home_appliance_related_service, :decimal, precision: 12, scale: 2, default: 0.0
      add :houseware, :decimal, precision: 12, scale: 2, default: 0.0
      add :household_tools_and_others, :decimal, precision: 12, scale: 2, default: 0.0
      add :household_goods, :decimal, precision: 12, scale: 2, default: 0.0
      add :housekeeping_service, :decimal, precision: 12, scale: 2, default: 0.0

      # ?06. health
      add :medicine, :decimal, precision: 12, scale: 2, default: 0.0
      add :medical_consumables, :decimal, precision: 12, scale: 2, default: 0.0
      add :health_care_supplies_and_equipment, :decimal, precision: 12, scale: 2, default: 0.0
      add :outpatient_medical_service, :decimal, precision: 12, scale: 2, default: 0.0
      add :dental_service, :decimal, precision: 12, scale: 2, default: 0.0
      add :other_medical_services, :decimal, precision: 12, scale: 2, default: 0.0
      add :hospitalization_service, :decimal, precision: 12, scale: 2, default: 0.0

      #?07.Transportation
      add :car_purchase, :decimal, precision: 12, scale: 2, default: 0.0

      add :purchase_other_transportation_equipment, :decimal,
        precision: 12,
        scale: 2,
        default: 0.0

      add :maintenance_and_repair_of_transportation_equipment, :decimal,
        precision: 12,
        scale: 2,
        default: 0.0

      add :transportation_fuel_costs, :decimal, precision: 12, scale: 2, default: 0.0

      add :other_personal_transportation_services, :decimal,
        precision: 12,
        scale: 2,
        default: 0.0

      add :rail_transportation, :decimal, precision: 12, scale: 2, default: 0.0
      add :land_transportation, :decimal, precision: 12, scale: 2, default: 0.0
      add :other_transportation, :decimal, precision: 12, scale: 2, default: 0.0

      add :other_transportation_related_services, :decimal,
        precision: 12,
        scale: 2,
        default: 0.0

      # ?08. Communication
      add :postal_service, :decimal, precision: 12, scale: 2, default: 0.0
      add :communication_equipment, :decimal, precision: 12, scale: 2, default: 0.0
      add :communication_service, :decimal, precision: 12, scale: 2, default: 0.0

      # ?09. Entertainment · Culture
      add :video_and_sound_equipment, :decimal, precision: 12, scale: 2, default: 0.0
      add :photo_optical_equipment, :decimal, precision: 12, scale: 2, default: 0.0
      add :information_processing_device, :decimal, precision: 12, scale: 2, default: 0.0
      add :record_carrier, :decimal, precision: 12, scale: 2, default: 0.0

      add :video_sound_and_information_device_repair, :decimal,
        precision: 12,
        scale: 2,
        default: 0.0

      add :entertainment_culture_durable_goods, :decimal, precision: 12, scale: 2, default: 0.0
      add :musical_instrument, :decimal, precision: 12, scale: 2, default: 0.0

      add :maintenance_and_repair_of_durable_entertainment_culture, :decimal,
        precision: 12,
        scale: 2,
        default: 0.0

      add :toys_and_hobbies, :decimal, precision: 12, scale: 2, default: 0.0
      add :camping_and_exercise_related_goods, :decimal, precision: 12, scale: 2, default: 0.0
      add :flower_related_goods, :decimal, precision: 12, scale: 2, default: 0.0
      add :pet_related_items, :decimal, precision: 12, scale: 2, default: 0.0
      add :flower_and_pet_services, :decimal, precision: 12, scale: 2, default: 0.0
      add :exercise_and_entertainment_service, :decimal, precision: 12, scale: 2, default: 0.0
      add :cultural_service, :decimal, precision: 12, scale: 2, default: 0.0
      add :lottery_ticket, :decimal, precision: 12, scale: 2, default: 0.0
      add :books, :decimal, precision: 12, scale: 2, default: 0.0
      add :other_prints, :decimal, precision: 12, scale: 2, default: 0.0
      add :phrases, :decimal, precision: 12, scale: 2, default: 0.0
      add :group_travel_cost, :decimal, precision: 12, scale: 2, default: 0.0

      # ?10. Education
      add :regular_education, :decimal, precision: 12, scale: 2, default: 0.0
      add :primary_education, :decimal, precision: 12, scale: 2, default: 0.0
      add :secondary_education, :decimal, precision: 12, scale: 2, default: 0.0
      add :higher_education, :decimal, precision: 12, scale: 2, default: 0.0
      add :school_and_moisturizing_education, :decimal, precision: 12, scale: 2, default: 0.0
      add :student_school_education, :decimal, precision: 12, scale: 2, default: 0.0
      add :adult_school_education, :decimal, precision: 12, scale: 2, default: 0.0
      add :other_education, :decimal, precision: 12, scale: 2, default: 0.0

      # ? 11.Food_and_lodging
      add :meal_cost, :decimal, precision: 12, scale: 2, default: 0.0
      add :room_charge, :decimal, precision: 12, scale: 2, default: 0.0

      # ? 12. Other products_and_services
      add :beauty_service, :decimal, precision: 12, scale: 2, default: 0.0
      add :beauty_equipment, :decimal, precision: 12, scale: 2, default: 0.0
      add :hygiene_and_beauty_products, :decimal, precision: 12, scale: 2, default: 0.0
      add :watches_and_ornaments, :decimal, precision: 12, scale: 2, default: 0.0
      add :other_personal_items, :decimal, precision: 12, scale: 2, default: 0.0
      add :welfare_facilities, :decimal, precision: 12, scale: 2, default: 0.0
      add :insurance, :decimal, precision: 12, scale: 2, default: 0.0
      add :other_finance, :decimal, precision: 12, scale: 2, default: 0.0
      add :other_services, :decimal, precision: 12, scale: 2, default: 0.0

      # ? non-consumption expenditure
      add :current_tax, :decimal, precision: 12, scale: 2, default: 0.0
      add :unusual_taxes, :decimal, precision: 12, scale: 2, default: 0.0
      add :pension, :decimal, precision: 12, scale: 2, default: 0.0
      add :social_insurance, :decimal, precision: 12, scale: 2, default: 0.0
      add :interest_expense, :decimal, precision: 12, scale: 2, default: 0.0
      add :furniture_simple_battery, :decimal, precision: 12, scale: 2, default: 0.0
      add :moved_to_a_non_profit_organization, :decimal, precision: 12, scale: 2, default: 0.0

      add :entity_id, references(:entities, type: :binary_id)
      add :family_id, references(:families, type: :binary_id)
      add :supul_id, references(:supuls, type: :binary_id)
      add :state_supul_id, references(:state_supuls, type: :binary_id)
      add :nation_supul_id, references(:nation_supuls, type: :binary_id)

      timestamps()
    end
  end
end
