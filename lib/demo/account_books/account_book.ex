defmodule Demo.AccountBooks.AccountBook do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "account_books" do
    field :revenue, :decimal, precision: 12, scale: 2, default: 0.0
    field :expense, :decimal, precision: 12, scale: 2, default: 0.0
    '''
    01.식료품 · 비주류음료
    곡물
    곡물가공품
    빵및떡류
    육류
    육류가공품
    신선수산동물
    염건수산동물
    기타수산동물가공
    유제품및알
    유지류
    과일및과일가공품
    채소및채소가공품
    해조및해조가공품
    당류및과자류
    조미식품
    기타식품
    커피및차
    쥬스및기타음료
    '''

    # ? 01.식료품 · 비주류음료
    field :grain, :decimal, precision: 12, scale: 2, default: 0.0
    field :grain_products, :decimal, precision: 12, scale: 2, default: 0.0
    field :bread_and_rice, :decimal, precision: 12, scale: 2, default: 0.0
    field :meat, :decimal, precision: 12, scale: 2, default: 0.0
    field :meat_products, :decimal, precision: 12, scale: 2, default: 0.0
    field :fresh_fish, :decimal, precision: 12, scale: 2, default: 0.0
    field :salt_and_salt_marine_animals, :decimal, precision: 12, scale: 2, default: 0.0
    field :other_aquatic_animal_processing, :decimal, precision: 12, scale: 2, default: 0.0
    field :dairy_products_and_eggs, :decimal, precision: 12, scale: 2, default: 0.0
    field :oil_and_fat, :decimal, precision: 12, scale: 2, default: 0.0
    field :fruit_and_fruit_processed_products, :decimal, precision: 12, scale: 2, default: 0.0

    field :vegetable_and_vegetable_processed_products, :decimal, precision: 12, scale: 2, default: 0.0

    field :seaweed_and_seaweed_processed_products, :decimal, precision: 12, scale: 2, default: 0.0
    field :sugars_and_sweets, :decimal, precision: 12, scale: 2, default: 0.0
    field :seasoned_food, :decimal, precision: 12, scale: 2, default: 0.0
    field :other_food, :decimal, precision: 12, scale: 2, default: 0.0
    field :coffee_and_tea, :decimal, precision: 12, scale: 2, default: 0.0
    field :juice_and_other_drinks, :decimal, precision: 12, scale: 2, default: 0.0

    '''
    02.주류 · 담배
    주류
    담배
    '''

    # ? 02.Liquor_and_tobacco
    field :liquor, :decimal, precision: 12, scale: 2, default: 0.0
    field :cigarette, :decimal, precision: 12, scale: 2, default: 0.0

    '''
    03.의류 · 신발
    직물및외의
    내의
    기타의복
    의복관련서비스
    신발
    신발서비스
    '''

    # ? 03.Clothing · Shoes
    field :fabric_and_others, :decimal, precision: 12, scale: 2, default: 0.0
    field :undergarment, :decimal, precision: 12, scale: 2, default: 0.0
    field :other_apparel, :decimal, precision: 12, scale: 2, default: 0.0
    field :clothing_related_services, :decimal, precision: 12, scale: 2, default: 0.0
    field :shoes, :decimal, precision: 12, scale: 2, default: 0.0
    field :footwear_service, :decimal, precision: 12, scale: 2, default: 0.0

    '''
    04.주거 · 수도 · 광열
    실제주거비
    주택유지및수선
    상하수도및폐기물처리
    기타주거관련서비스
    연료비
    '''

    # ?04.Housing, water supply, light heat
    field :actual_residential_cost, :decimal, precision: 12, scale: 2, default: 0.0
    field :housing_maintenance_and_repair, :decimal, precision: 12, scale: 2, default: 0.0
    field :water_and_sewage_and_waste_treatment, :decimal, precision: 12, scale: 2, default: 0.0
    field :other_residential_services, :decimal, precision: 12, scale: 2, default: 0.0
    field :fuel_costs, :decimal, precision: 12, scale: 2, default: 0.0

    '''
    05.가정용품 · 가사서비스
    가구및조명
    실내장식
    가구·조명및장식서비스
    가정용섬유
    가전및가정용기기
    가전관련서비스
    가사용품
    가정용공구및기타
    가사소모품
    가사서비스
    '''

    # ?05. household goods_and_housework service
    field :furniture_and_lighting, :decimal, precision: 12, scale: 2, default: 0.0
    field :interior_decoration, :decimal, precision: 12, scale: 2, default: 0.0
    field :furniture_lighting_and_decoration_services, :decimal, precision: 12, scale: 2, default: 0.0
    field :household_textile, :decimal, precision: 12, scale: 2, default: 0.0
    field :household_appliances_and_household_appliances, :decimal, precision: 12, scale: 2, default: 0.0
    field :home_appliance_related_service, :decimal, precision: 12, scale: 2, default: 0.0
    field :houseware, :decimal, precision: 12, scale: 2, default: 0.0
    field :household_tools_and_others, :decimal, precision: 12, scale: 2, default: 0.0
    field :household_goods, :decimal, precision: 12, scale: 2, default: 0.0
    field :housekeeping_service, :decimal, precision: 12, scale: 2, default: 0.0

    '''
    #?06.보건
    의약품
    의료용소모품
    보건의료용품및기구
    외래의료서비스
    치과서비스
    기타의료서비스
    입원서비스
    '''

    # ?06. health
    field :medicine, :decimal, precision: 12, scale: 2, default: 0.0
    field :medical_consumables, :decimal, precision: 12, scale: 2, default: 0.0
    field :health_care_supplies_and_equipment, :decimal, precision: 12, scale: 2, default: 0.0
    field :outpatient_medical_service, :decimal, precision: 12, scale: 2, default: 0.0
    field :dental_service, :decimal, precision: 12, scale: 2, default: 0.0
    field :other_medical_services, :decimal, precision: 12, scale: 2, default: 0.0
    field :hospitalization_service, :decimal, precision: 12, scale: 2, default: 0.0

    '''
    #?07.교통
    자동차구입
    기타운송기구구입
    운송기구유지및수리
    운송기구연료비
    기타개인교통서비스
    철도운송
    육상운송
    기타운송
    기타교통관련서비스  
    '''

    #?07.Transportation
    field :car_purchase, :decimal, precision: 12, scale: 2, default: 0.0
    field :purchase_other_transportation_equipment, :decimal, precision: 12, scale: 2, default: 0.0
    field :maintenance_and_repair_of_transportation_equipment, :decimal, precision: 12, scale: 2, default: 0.0
    field :transportation_fuel_costs, :decimal, precision: 12, scale: 2, default: 0.0
    field :other_personal_transportation_services, :decimal, precision: 12, scale: 2, default: 0.0
    field :rail_transportation, :decimal, precision: 12, scale: 2, default: 0.0
    field :land_transportation, :decimal, precision: 12, scale: 2, default: 0.0
    field :other_transportation, :decimal, precision: 12, scale: 2, default: 0.0
    field :other_transportation_related_services, :decimal, precision: 12, scale: 2, default: 0.0

    '''
    08.통신
    우편서비스
    통신장비
    통신서비스
    '''

    # ?08. Communication
    field :postal_service, :decimal, precision: 12, scale: 2, default: 0.0
    field :communication_equipment, :decimal, precision: 12, scale: 2, default: 0.0
    field :communication_service, :decimal, precision: 12, scale: 2, default: 0.0

    '''
    09.오락 · 문화
    영상음향기기
    사진광학장비
    정보처리장치
    기록매체
    영상음향및정보기기수리
    오락문화내구재
    악기기구
    오락문화내구재유지및수리
    장난감및취미용품
    캠핑및운동관련용품
    화훼관련용품
    애완동물관련물품
    화훼및애완동물서비스
    운동및오락서비스
    문화서비스
    복권
    서적
    기타인쇄물
    문구
    단체여행비
    '''

    # ?09. Entertainment · Culture
    field :video_and_sound_equipment, :decimal, precision: 12, scale: 2, default: 0.0
    field :photo_optical_equipment, :decimal, precision: 12, scale: 2, default: 0.0
    field :information_processing_device, :decimal, precision: 12, scale: 2, default: 0.0
    field :record_carrier, :decimal, precision: 12, scale: 2, default: 0.0
    field :video_sound_and_information_device_repair, :decimal, precision: 12, scale: 2, default: 0.0
    field :entertainment_culture_durable_goods, :decimal, precision: 12, scale: 2, default: 0.0
    field :musical_instrument, :decimal, precision: 12, scale: 2, default: 0.0
    field :maintenance_and_repair_of_durable_entertainment_culture, :decimal, precision: 12, scale: 2, default: 0.0
    field :toys_and_hobbies, :decimal, precision: 12, scale: 2, default: 0.0
    field :camping_and_exercise_related_goods, :decimal, precision: 12, scale: 2, default: 0.0
    field :flower_related_goods, :decimal, precision: 12, scale: 2, default: 0.0
    field :pet_related_items, :decimal, precision: 12, scale: 2, default: 0.0
    field :flower_and_pet_services, :decimal, precision: 12, scale: 2, default: 0.0
    field :exercise_and_entertainment_service, :decimal, precision: 12, scale: 2, default: 0.0
    field :cultural_service, :decimal, precision: 12, scale: 2, default: 0.0
    field :lottery_ticket, :decimal, precision: 12, scale: 2, default: 0.0
    field :books, :decimal, precision: 12, scale: 2, default: 0.0
    field :other_prints, :decimal, precision: 12, scale: 2, default: 0.0
    field :phrases, :decimal, precision: 12, scale: 2, default: 0.0
    field :group_travel_cost, :decimal, precision: 12, scale: 2, default: 0.0

    '''
    10.교육
    정규교육
    초등교육
    중등교육
    고등교육
    학원및보습교육
    학생학원교육
    성인학원교육
    기타교육
    '''

    # ?10. Education
    field :regular_education, :decimal, precision: 12, scale: 2, default: 0.0
    field :primary_education, :decimal, precision: 12, scale: 2, default: 0.0
    field :secondary_education, :decimal, precision: 12, scale: 2, default: 0.0
    field :higher_education, :decimal, precision: 12, scale: 2, default: 0.0
    field :school_and_moisturizing_education, :decimal, precision: 12, scale: 2, default: 0.0
    field :student_school_education, :decimal, precision: 12, scale: 2, default: 0.0
    field :adult_school_education, :decimal, precision: 12, scale: 2, default: 0.0
    field :other_education, :decimal, precision: 12, scale: 2, default: 0.0

    '''
    11.음식 · 숙박
    식사비
    숙박비
    '''

    # ? 11.Food_and_lodging
    field :meal_cost, :decimal, precision: 12, scale: 2, default: 0.0
    field :room_charge, :decimal, precision: 12, scale: 2, default: 0.0

    '''
    12.기타상품 · 서비스
    이미용서비스
    이미용기기
    위생및이미용용품
    시계및장신구
    기타개인용품
    복지시설
    보험
    기타금융
    기타서비스
    '''

    # ? 12. Other products_and_services
    field :beauty_service, :decimal, precision: 12, scale: 2, default: 0.0
    field :beauty_equipment, :decimal, precision: 12, scale: 2, default: 0.0
    field :hygiene_and_beauty_products, :decimal, precision: 12, scale: 2, default: 0.0
    field :watches_and_ornaments, :decimal, precision: 12, scale: 2, default: 0.0
    field :other_personal_items, :decimal, precision: 12, scale: 2, default: 0.0
    field :welfare_facilities, :decimal, precision: 12, scale: 2, default: 0.0
    field :insurance, :decimal, precision: 12, scale: 2, default: 0.0
    field :other_finance, :decimal, precision: 12, scale: 2, default: 0.0
    field :other_services, :decimal, precision: 12, scale: 2, default: 0.0

    '''
    #? 비소비지출
    경상조세
    비경상조세
    연금
    사회보험
    이자비용
    가구간이전지출
    비영리단체로이전
    '''

    # ? non-consumption expenditure
    field :current_tax, :decimal, precision: 12, scale: 2, default: 0.0
    field :unusual_taxes, :decimal, precision: 12, scale: 2, default: 0.0
    field :pension, :decimal, precision: 12, scale: 2, default: 0.0
    field :social_insurance, :decimal, precision: 12, scale: 2, default: 0.0
    field :interest_expense, :decimal, precision: 12, scale: 2, default: 0.0
    field :furniture_simple_battery, :decimal, precision: 12, scale: 2, default: 0.0
    field :moved_to_a_non_profit_organization, :decimal, precision: 12, scale: 2, default: 0.0
  
    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    belongs_to :family, Demo.Families.Family, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Demo.StateSupuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id

    timestamps()

  
  end

  @fields [
    :revenue,
    :expense, 
    
    :grain, 
    :grain_products, 
    :bread_and_rice, 
    :meat, 
    :meat_products, 
    :fresh_fish, 
    :salt_and_salt_marine_animals, 
    :other_aquatic_animal_processing, 
    :dairy_products_and_eggs, 
    :oil_and_fat, 
    :fruit_and_fruit_processed_products, 

    :vegetable_and_vegetable_processed_products, 

    :seaweed_and_seaweed_processed_products, 
    :sugars_and_sweets, 
    :seasoned_food, 
    :other_food, 
    :coffee_and_tea, 
    :juice_and_other_drinks, 

    :liquor, 
    :cigarette, 


    :fabric_and_others, 
    :undergarment, 
    :other_apparel, 
    :clothing_related_services, 
    :shoes, 
    :footwear_service, 

    :actual_residential_cost, 
    :housing_maintenance_and_repair, 
    :water_and_sewage_and_waste_treatment, 
    :other_residential_services, 
    :fuel_costs, 


    :furniture_and_lighting, 
    :interior_decoration, 
    :furniture_lighting_and_decoration_services, 
    :household_textile, 
    :household_appliances_and_household_appliances, 
    :home_appliance_related_service, 
    :houseware, 
    :household_tools_and_others, 
    :household_goods, 
    :housekeeping_service, 


    :medicine, 
    :medical_consumables, 
    :health_care_supplies_and_equipment, 
    :outpatient_medical_service, 
    :dental_service, 
    :other_medical_services, 
    :hospitalization_service, 

    :car_purchase, 
    :purchase_other_transportation_equipment, 
    :maintenance_and_repair_of_transportation_equipment, 
    :transportation_fuel_costs, 
    :other_personal_transportation_services, 
    :rail_transportation, 
    :land_transportation, 
    :other_transportation, 
    :other_transportation_related_services, 

    :postal_service, 
    :communication_equipment, 
    :communication_service, 

    :video_and_sound_equipment, 
    :photo_optical_equipment, 
    :information_processing_device, 
    :record_carrier, 
    :video_sound_and_information_device_repair, 
    :entertainment_culture_durable_goods, 
    :musical_instrument, 
    :maintenance_and_repair_of_durable_entertainment_culture, 
    :toys_and_hobbies, 
    :camping_and_exercise_related_goods, 
    :flower_related_goods, 
    :pet_related_items, 
    :flower_and_pet_services, 
    :exercise_and_entertainment_service, 
    :cultural_service, 
    :lottery_ticket, 
    :books, 
    :other_prints, 
    :phrases, 
    :group_travel_cost, 


    :regular_education, 
    :primary_education, 
    :secondary_education, 
    :higher_education, 
    :school_and_moisturizing_education, 
    :student_school_education, 
    :adult_school_education, 
    :other_education, 


    :meal_cost, 
    :room_charge, 


    :beauty_service, 
    :beauty_equipment, 
    :hygiene_and_beauty_products, 
    :watches_and_ornaments, 
    :other_personal_items, 
    :welfare_facilities, 
    :insurance, 
    :other_finance, 
    :other_services, 

    :current_tax, 
    :unusual_taxes, 
    :pension, 
    :social_insurance, 
    :interest_expense, 
    :furniture_simple_battery, 
    :moved_to_a_non_profit_organization, 
  ]
  @doc false
  def changeset(account_book, attrs) do
    account_book
    |> cast(attrs, @fields)
    |> validate_required([])
  end

end
