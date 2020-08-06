defmodule Demo.AccountBooks do
  @moduledoc """
  The AccountBooks context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.AccountBooks.AccountBook
  alias Demo.Entities.Entity
  alias Demo.Families.Family
  alias Demo.Supuls.Supul
  alias Demo.StateSupuls.StateSupul
  alias Demo.NationSupuls.NationSupul

  def list_account_books do
    Repo.all(AccountBook)
  end

  def get_account_book!(id), do: Repo.get!(AccountBook, id)

  def get_entity_account_book(entity_id) do
    AccountBook
    |> entity_account_book_query(entity_id)
    |> Repo.one()
  end

  defp entity_account_book_query(query, entity_id) do
    from(f in query, where: f.entity_id == ^entity_id)
  end 

  def add_expense(%AccountBook{} = account_book, %{amount: amount}) do
    accrued_expense = Decimal.add(account_book.expense, amount)
    update_account_book(account_book, %{expense: accrued_expense})
  end

  def add_revenue(%AccountBook{} = account_book, %{amount: amount}) do
    accrued_revenue = Decimal.add(account_book.revenue, amount)
    update_account_book(account_book, %{revenue: accrued_revenue})
  end

'''
  Below are codes to create a new entity or supul based on already existing members.
'''
  # ? For a user
  def create_account_book(%Entity{} = entity) do
    attrs = create_attrs(entity)

    family = Repo.preload(entity, :family).family
    %AccountBook{}
    |> AccountBook.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Ecto.Changeset.put_assoc(:family, family)
    |> Repo.insert()
  end

  # ? For a family
  def create_account_book(%Family{} = family) do
    attrs = create_attrs(family)

    %AccountBook{}
    |> AccountBook.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:family, family)
    |> Repo.insert()
  end

  # ? Supul  
  def create_account_book(%Supul{} = supul) do
    attrs = create_attrs(supul)

    %AccountBook{}
    |> AccountBook.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:supul, supul)
    |> Repo.insert()
  end

  def create_account_book(%StateSupul{} = state_supul) do
    attrs = create_attrs(state_supul)
 
    %AccountBook{}
    |> AccountBook.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:state_supul, state_supul)
    |> Repo.insert()
  end

  def create_account_book(%NationSupul{} = nation_supul) do
    attrs = create_attrs(nation_supul)

    %AccountBook{}
    |> AccountBook.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:nation_supul, nation_supul)
    |> Repo.insert()
  end

  def update_account_book(%AccountBook{} = account_book, attrs \\ %{}) do
    account_book
    |> AccountBook.changeset(attrs)
    |> Repo.update()
  end

  def delete_account_book(%AccountBook{} = account_book) do
    Repo.delete(account_book)
  end

  def change_account_book(%AccountBook{} = account_book) do
    AccountBook.changeset(account_book, %{})
  end

  defp create_attrs(family_or_supul) do
    
    #? If there already are members of the family or the supul parameter.
    list_AB = []

    case family_or_supul do
      %Family{} ->
        entities = Repo.preload(family_or_supul, :entities).entities

        list_AB =
          Enum.map(entities, fn entity -> Repo.preload(entity, :account_book).account_book end)

      %Supul{} ->
        families = Repo.preload(family_or_supul, :families).families

        list_AB =
          Enum.map(families, fn family -> Repo.preload(family, :account_book).account_book end)

      %StateSupul{} ->
        supuls = Repo.preload(family_or_supul, :supuls).supuls

        list_AB =
          Enum.map(supuls, fn supul -> Repo.preload(supul, :account_book).account_book end)

      %NationSupul{} ->
        state_supuls = Repo.preload(family_or_supul, :state_supuls).state_supuls

        list_AB =
          Enum.map(state_supuls, fn state_supul ->
            Repo.preload(state_supul, :account_book).account_book
          end)

      _ ->
        "error"
    end

    expense =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.expense, acc) end)

    revenue =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.revenue, acc) end)

    grain =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.grain, acc) end)

    grain_products =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.grain_products, acc)
      end)

    bread_and_rice =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.bread_and_rice, acc)
      end)

    meat =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.meat, acc) end)

    meat_products =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.meat_products, acc)
      end)

    fresh_fish =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.fresh_fish, acc)
      end)

    salt_and_salt_marine_animals =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.salt_and_salt_marine_animals, acc)
      end)

    other_aquatic_animal_processing =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_aquatic_animal_processing, acc)
      end)

    dairy_products_and_eggs =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.dairy_products_and_eggs, acc)
      end)

    oil_and_fat =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.oil_and_fat, acc)
      end)

    fruit_and_fruit_processed_products =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.fruit_and_fruit_processed_products, acc)
      end)

    vegetable_and_vegetable_processed_products =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.vegetable_and_vegetable_processed_products, acc)
      end)

    seaweed_and_seaweed_processed_products =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.seaweed_and_seaweed_processed_products, acc)
      end)

    sugars_and_sweets =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.sugars_and_sweets, acc)
      end)

    seasoned_food =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.seasoned_food, acc)
      end)

    other_food =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_food, acc)
      end)

    coffee_and_tea =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.coffee_and_tea, acc)
      end)

    juice_and_other_drinks =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.juice_and_other_drinks, acc)
      end)

    liquor =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.liquor, acc) end)

    cigarette =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.cigarette, acc)
      end)

    fabric_and_others =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.fabric_and_others, acc)
      end)

    undergarment =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.undergarment, acc)
      end)

    other_apparel =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_apparel, acc)
      end)

    clothing_related_services =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.clothing_related_services, acc)
      end)

    shoes =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.shoes, acc) end)

    footwear_service =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.footwear_service, acc)
      end)

    actual_residential_cost =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.actual_residential_cost, acc)
      end)

    housing_maintenance_and_repair =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.housing_maintenance_and_repair, acc)
      end)

    water_and_sewage_and_waste_treatment =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.water_and_sewage_and_waste_treatment, acc)
      end)

    other_residential_services =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_residential_services, acc)
      end)

    fuel_costs =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.fuel_costs, acc)
      end)

    furniture_and_lighting =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.furniture_and_lighting, acc)
      end)

    interior_decoration =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.interior_decoration, acc)
      end)

    furniture_lighting_and_decoration_services =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.furniture_lighting_and_decoration_services, acc)
      end)

    household_textile =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.household_textile, acc)
      end)

    household_appliances_and_household_appliances =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.household_appliances_and_household_appliances, acc)
      end)

    home_appliance_related_service =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.home_appliance_related_service, acc)
      end)

    houseware =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.houseware, acc)
      end)

    household_tools_and_others =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.household_tools_and_others, acc)
      end)

    household_goods =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.household_goods, acc)
      end)

    housekeeping_service =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.housekeeping_service, acc)
      end)

    medicine =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.medicine, acc) end)

    medical_consumables =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.medical_consumables, acc)
      end)

    health_care_supplies_and_equipment =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.health_care_supplies_and_equipment, acc)
      end)

    outpatient_medical_service =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.outpatient_medical_service, acc)
      end)

    dental_service =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.dental_service, acc)
      end)

    other_medical_services =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_medical_services, acc)
      end)

    hospitalization_service =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.hospitalization_service, acc)
      end)

    car_purchase =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.car_purchase, acc)
      end)

    purchase_other_transportation_equipment =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.purchase_other_transportation_equipment, acc)
      end)

    maintenance_and_repair_of_transportation_equipment =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.maintenance_and_repair_of_transportation_equipment, acc)
      end)

    transportation_fuel_costs =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.transportation_fuel_costs, acc)
      end)

    other_personal_transportation_services =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_personal_transportation_services, acc)
      end)

    rail_transportation =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.rail_transportation, acc)
      end)

    land_transportation =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.land_transportation, acc)
      end)

    other_transportation =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_transportation, acc)
      end)

    other_transportation_related_services =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_transportation_related_services, acc)
      end)

    postal_service =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.postal_service, acc)
      end)

    communication_equipment =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.communication_equipment, acc)
      end)

    communication_service =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.communication_service, acc)
      end)

    video_and_sound_equipment =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.video_and_sound_equipment, acc)
      end)

    photo_optical_equipment =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.photo_optical_equipment, acc)
      end)

    information_processing_device =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.information_processing_device, acc)
      end)

    record_carrier =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.record_carrier, acc)
      end)

    video_sound_and_information_device_repair =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.video_sound_and_information_device_repair, acc)
      end)

    entertainment_culture_durable_goods =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.entertainment_culture_durable_goods, acc)
      end)

    musical_instrument =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.musical_instrument, acc)
      end)

    maintenance_and_repair_of_durable_entertainment_culture =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.maintenance_and_repair_of_durable_entertainment_culture, acc)
      end)

    toys_and_hobbies =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.toys_and_hobbies, acc)
      end)

    camping_and_exercise_related_goods =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.camping_and_exercise_related_goods, acc)
      end)

    flower_related_goods =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.flower_related_goods, acc)
      end)

    pet_related_items =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.pet_related_items, acc)
      end)

    flower_and_pet_services =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.flower_and_pet_services, acc)
      end)

    exercise_and_entertainment_service =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.exercise_and_entertainment_service, acc)
      end)

    cultural_service =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.cultural_service, acc)
      end)

    lottery_ticket =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.lottery_ticket, acc)
      end)

    books =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.books, acc) end)

    other_prints =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_prints, acc)
      end)

    phrases =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.phrases, acc) end)

    group_travel_cost =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.group_travel_cost, acc)
      end)

    regular_education =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.regular_education, acc)
      end)

    primary_education =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.primary_education, acc)
      end)

    secondary_education =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.secondary_education, acc)
      end)

    higher_education =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.higher_education, acc)
      end)

    school_and_moisturizing_education =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.school_and_moisturizing_education, acc)
      end)

    student_school_education =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.student_school_education, acc)
      end)

    adult_school_education =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.adult_school_education, acc)
      end)

    other_education =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_education, acc)
      end)

    meal_cost =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.meal_cost, acc)
      end)

    room_charge =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.room_charge, acc)
      end)

    beauty_service =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.beauty_service, acc)
      end)

    beauty_equipment =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.beauty_equipment, acc)
      end)

    hygiene_and_beauty_products =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.hygiene_and_beauty_products, acc)
      end)

    watches_and_ornaments =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.watches_and_ornaments, acc)
      end)

    other_personal_items =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_personal_items, acc)
      end)

    welfare_facilities =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.welfare_facilities, acc)
      end)

    insurance =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.insurance, acc)
      end)

    other_finance =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_finance, acc)
      end)

    other_services =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_services, acc)
      end)

    current_tax =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.current_tax, acc)
      end)

    unusual_taxes =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.unusual_taxes, acc)
      end)

    pension =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.pension, acc) end)

    social_insurance =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.social_insurance, acc)
      end)

    interest_expense =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.interest_expense, acc)
      end)

    furniture_simple_battery =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.furniture_simple_battery, acc)
      end)

    moved_to_a_non_profit_organization =
      Enum.reduce(list_AB, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.moved_to_a_non_profit_organization, acc)
      end)

    attrs = %{
      grain: grain,
      grain_products: grain_products,
      bread_and_rice: bread_and_rice,
      meat: meat,
      meat_products: meat_products,
      fresh_fish: fresh_fish,
      salt_and_salt_marine_animals: salt_and_salt_marine_animals,
      other_aquatic_animal_processing: other_aquatic_animal_processing,
      dairy_products_and_eggs: dairy_products_and_eggs,
      oil_and_fat: oil_and_fat,
      fruit_and_fruit_processed_products: fruit_and_fruit_processed_products,
      vegetable_and_vegetable_processed_products: vegetable_and_vegetable_processed_products,
      seaweed_and_seaweed_processed_products: seaweed_and_seaweed_processed_products,
      sugars_and_sweets: sugars_and_sweets,
      seasoned_food: seasoned_food,
      other_food: other_food,
      coffee_and_tea: coffee_and_tea,
      juice_and_other_drinks: juice_and_other_drinks,
      liquor: liquor,
      cigarette: cigarette,
      fabric_and_others: fabric_and_others,
      undergarment: undergarment,
      other_apparel: other_apparel,
      clothing_related_services: clothing_related_services,
      shoes: shoes,
      footwear_service: footwear_service,
      actual_residential_cost: actual_residential_cost,
      housing_maintenance_and_repair: housing_maintenance_and_repair,
      water_and_sewage_and_waste_treatment: water_and_sewage_and_waste_treatment,
      other_residential_services: other_residential_services,
      fuel_costs: fuel_costs,
      furniture_and_lighting: furniture_and_lighting,
      interior_decoration: interior_decoration,
      furniture_lighting_and_decoration_services: furniture_lighting_and_decoration_services,
      household_textile: household_textile,
      household_appliances_and_household_appliances:
        household_appliances_and_household_appliances,
      home_appliance_related_service: home_appliance_related_service,
      houseware: houseware,
      household_tools_and_others: household_tools_and_others,
      household_goods: household_goods,
      housekeeping_service: housekeeping_service,
      medicine: medicine,
      medical_consumables: medical_consumables,
      health_care_supplies_and_equipment: health_care_supplies_and_equipment,
      outpatient_medical_service: outpatient_medical_service,
      dental_service: dental_service,
      other_medical_services: other_medical_services,
      hospitalization_service: hospitalization_service,
      car_purchase: car_purchase,
      purchase_other_transportation_equipment: purchase_other_transportation_equipment,
      maintenance_and_repair_of_transportation_equipment:
        maintenance_and_repair_of_transportation_equipment,
      transportation_fuel_costs: transportation_fuel_costs,
      other_personal_transportation_services: other_personal_transportation_services,
      rail_transportation: rail_transportation,
      land_transportation: land_transportation,
      other_transportation: other_transportation,
      other_transportation_related_services: other_transportation_related_services,
      postal_service: postal_service,
      communication_equipment: communication_equipment,
      communication_service: communication_service,
      video_and_sound_equipment: video_and_sound_equipment,
      photo_optical_equipment: photo_optical_equipment,
      information_processing_device: information_processing_device,
      record_carrier: record_carrier,
      video_sound_and_information_device_repair: video_sound_and_information_device_repair,
      entertainment_culture_durable_goods: entertainment_culture_durable_goods,
      musical_instrument: musical_instrument,
      maintenance_and_repair_of_durable_entertainment_culture:
        maintenance_and_repair_of_durable_entertainment_culture,
      toys_and_hobbies: toys_and_hobbies,
      camping_and_exercise_related_goods: camping_and_exercise_related_goods,
      flower_related_goods: flower_related_goods,
      pet_related_items: pet_related_items,
      flower_and_pet_services: flower_and_pet_services,
      exercise_and_entertainment_service: exercise_and_entertainment_service,
      cultural_service: cultural_service,
      lottery_ticket: lottery_ticket,
      books: books,
      other_prints: other_prints,
      phrases: phrases,
      group_travel_cost: group_travel_cost,
      regular_education: regular_education,
      primary_education: primary_education,
      secondary_education: secondary_education,
      higher_education: higher_education,
      school_and_moisturizing_education: school_and_moisturizing_education,
      student_school_education: student_school_education,
      adult_school_education: adult_school_education,
      other_education: other_education,
      meal_cost: meal_cost,
      room_charge: room_charge,
      beauty_service: beauty_service,
      beauty_equipment: beauty_equipment,
      hygiene_and_beauty_products: hygiene_and_beauty_products,
      watches_and_ornaments: watches_and_ornaments,
      other_personal_items: other_personal_items,
      welfare_facilities: welfare_facilities,
      insurance: insurance,
      other_finance: other_finance,
      other_services: other_services,
      current_tax: current_tax,
      unusual_taxes: unusual_taxes,
      pension: pension,
      social_insurance: social_insurance,
      interest_expense: interest_expense,
      furniture_simple_battery: furniture_simple_battery,
      moved_to_a_non_profit_organization: moved_to_a_non_profit_organization
    }
  end
end
