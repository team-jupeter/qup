import Ecto.Query
import Ecto.Changeset
alias Demo.Repo

# ? init nations
alias Demo.Nations.Nation

korea = Nation.changeset(%Nation{}, %{name: "South Korea"}) |> Repo.insert!()
usa = Nation.changeset(%Nation{}, %{name: "USA"}) |> Repo.insert!()

# ? init supuls. For example, Korea will have about 5,000 supuls.
alias Demo.GlobalSupuls.GlobalSupul
alias Demo.NationSupuls.NationSupul
alias Demo.StateSupuls.StateSupul
alias Demo.Supuls.Supul

global_supul =
  GlobalSupul.changeset(%GlobalSupul{}, %{name: "Global Supul", supul_code: 0x00000000}) \
  |> Repo.insert!()

korea_supul =
  NationSupul.changeset(%NationSupul{}, %{name: "Korea Supul", supul_code: 0x52000000}) \
  |> Repo.insert!()

jejudo_supul =
  StateSupul.changeset(%StateSupul{}, %{name: "Jejudo State Supul", supul_code: 0x01434500}) \
  |> Repo.insert!()

hankyung_supul =
  Supul.changeset(%Supul{}, %{name: "Hankyung_County", supul_code: 0x01434501}) \
  |> Repo.insert!()

orange_supul =
  Supul.changeset(%Supul{}, %{name: "Orange_County", supul_code: 0x052454501}) \
  |> Repo.insert!()

# ? init users
alias Demo.Accounts.User

# {ok, mr_hong} = User.changeset(%User{}, %{name: "Hong Gildong"}) |> Repo.insert
mr_hong =
  User.changeset(%User{}, %{name: "Hong Gildong", email: "hong_gil_dong@82345.kr"}) \
  |> Repo.insert!()

ms_sung =
  User.changeset(%User{}, %{name: "Sung Chunhyang", email: "sung_chun_hyang@82345.kr"}) \
  |> Repo.insert!()

gab =
  User.changeset(%User{}, %{name: "GAB: Global Autonomous Bank", email: "gab@000011.un"}) \
  |> Repo.insert!()

mr_musk =
  User.changeset(%User{}, %{name: "Ellen Musk", email: "mr_ellen_musk@000011.us"}) \
  |> Repo.insert!()

# ? init taxations: kts = korea tax service, irs = internal revenue service
alias Demo.Taxations.Taxation

kts =
  Taxation.changeset(%Taxation{}, %{name: "Korea Tax Service", nation_id: korea.id}) \
  |> Repo.insert!()

irs =
  Taxation.changeset(%Taxation{}, %{name: "US Internal Revenue Service", nation_id: usa.id}) \
  |> Repo.insert!()

# ? init entities
alias Demo.Business.Entity

hong_entity =
  Entity.changeset(%Entity{}, %{name: "Hong Gildong Entity", email: "hong_gil_dong@82345.kr"}) \
  |> Repo.insert!()

tomi_entity =
  Entity.changeset(%Entity{}, %{name: "Sung Chunhyang Entity", email: "sung_chun_hyang@82345.kr"}) \
  |> Repo.insert!()

hankyung_gab =
  Entity.changeset(%Entity{}, %{name: "Hankyung GAB Branch", email: "hankyung_gab@3435.kr"}) \
  |> Repo.insert!()

tesla_entity =
  Entity.changeset(%Entity{}, %{name: "Tesla", email: "tesl@3435.us"}) |> Repo.insert!() \

# ? put_assoc user and entity
Repo.preload(hong_entity, [:users]) \
|> Ecto.Changeset.change() \
|> Ecto.Changeset.put_assoc(:users, [mr_hong]) \
|> Repo.update!()

Repo.preload(tomi_entity, [:users]) \
|> Ecto.Changeset.change() \
|> Ecto.Changeset.put_assoc(:users, [ms_sung]) \
|> Repo.update!()

Repo.preload(hankyung_gab, [:users]) \
|> Ecto.Changeset.change() \
|> Ecto.Changeset.put_assoc(:users, [gab]) \
|> Repo.update!()

Repo.preload(tesla_entity, [:users]) \
|> Ecto.Changeset.change() \
|> Ecto.Changeset.put_assoc(:users, [mr_musk]) \
|> Repo.update!()

# ? make a GAB branch for Hangkyung Supul. Remember every supul has one, only one GAB branch.
hankyung_gab = Ecto.build_assoc(hankyung_supul, :entities, hankyung_gab)
tomi_entity = Ecto.build_assoc(hankyung_supul, :entities, tomi_entity)
tesla_entity = Ecto.build_assoc(orange_supul, :entities, tesla_entity)

# ? build_assoc entities with nations
hankyung_gab = Ecto.build_assoc(korea, :entities, hankyung_gab)
hong_entity = Ecto.build_assoc(korea, :entities, hong_entity)
tesla_entity = Ecto.build_assoc(usa, :entities, tesla_entity)

Repo.preload(hankyung_gab, [:nation, :supul])

# ? prepare financial statements for entities.
alias Demo.Reports.FinancialReport
alias Demo.Reports.BalanceSheet
alias Demo.Reports.GabBalanceSheet
alias Demo.Reports.GopangBalanceSheet
alias Demo.Reports.SupulBalanceSheet
alias Demo.Reports.GovBalanceSheet

korea_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: hankyung_gab.id})  \
  |> Repo.insert!()

hankyung_supul_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: hankyung_gab.id})  \
  |> Repo.insert!()

hong_entity_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: hong_entity.id})  \
  |> Repo.insert!()

tesla_entity_FR =
  FinancialReport.changeset(%FinancialReport{}, %{
    entity_id: tesla_entity.id,
    num_of_treasury_stocks: 10000
  }) \
  |> Repo.insert!()

tomi_entity_FR =
  FinancialReport.changeset(
    %FinancialReport{},
    %{
      entity_id: tomi_entity.id,
      num_of_shares: 1_000_000,
      market_capitalization: Decimal.from_float(30000000.00),
      stock_price: Decimal.from_float(30.00),
      debt_int_rate: Decimal.from_float(0.05),
      intric_value: Decimal.from_float(28.95),
      num_of_treasury_stocks: 100_000
    }
  ) \
  |> Repo.insert!()

korea_BS =
  Ecto.build_assoc(korea_FR, :supul_balance_sheet, %GovBalanceSheet{
    monetary_unit: "KRW",
    t1: 99_999_990.00
  }) \
  |> Repo.insert!()

hankyung_supul_BS =
  Ecto.build_assoc(hankyung_supul_FR, :supul_balance_sheet, %GabBalanceSheet{
    monetary_unit: "KRW",
    t1: 10000.00
  }) \
  |> Repo.insert!()

hong_entity_BS =
  Ecto.build_assoc(hong_entity_FR, :balance_sheet, %BalanceSheet{
    cash: Decimal.from_float(50_000_000.00),
    t1s: [%{input: korea.id, output: hong_entity.id, amount: Decimal.from_float(10_000.00)}]
  }) \
  |> Repo.insert!()

tesla_entity_BS =
  Ecto.build_assoc(tesla_entity_FR, :balance_sheet, %BalanceSheet{
    cash: Decimal.from_float(50_000_000.00),
    t1s: [%{input: korea.id, output: tesla_entity.id, amount: Decimal.from_float(10_000.00)}]
  }) \
  |> Repo.insert!()

tomi_entity_BS =
  Ecto.build_assoc(tomi_entity_FR, :balance_sheet, %BalanceSheet{
    fixed_assets: [%{building: 1.0}],
    t1s: [%{input: korea.id, output: tomi_entity.id, amount: Decimal.from_float(10_000.00)}]
  }) \
  |> Repo.insert!()

'''

CRYPTO

'''

# ? openssl genrsa -out tesla_private_key.pem 2048
# ? openssl rsa -in tesla_private_key.pem -pubout > tesla_public_key.pem
hankyung_rsa_priv_key = ExPublicKey.load!("./hankyung_private_key.pem")
hankyung_rsa_pub_key = ExPublicKey.load!("./hankyung_public_key.pem")

tesla_rsa_priv_key = ExPublicKey.load!("./tesla_private_key.pem")
tesla_rsa_pub_key = ExPublicKey.load!("./tesla_public_key.pem")

hong_rsa_priv_key = ExPublicKey.load!("./hong_private_key.pem")
hong_rsa_pub_key = ExPublicKey.load!("./hong_public_key.pem")

tomi_rsa_priv_key = ExPublicKey.load!("./tomi_private_key.pem")
tomi_rsa_pub_key = ExPublicKey.load!("./tomi_public_key.pem")





'''

STOCK MARKET

T2_Manager

COMPOSING T2_POOL

First, buy one share from each entity in the nation. 
Second, calculate intrinsic_value, re_fmv from its financial statements. 
Third, buy more shares from those with large intrinsic_to_price_gab.
Forth, repeat the third process.
Fifth, sell some shares of those with small intrinsic_to_price_gab.

'''
#? FIRST
#? Buy one stock from each company in Korea to get t2_index

korea = Repo.preload(korea, [:entities])

for x <- korea.entities do #? for each entity registered in Korea. 
  
  #? repeat the code below for each entity of which nation_id is korea.id

end

#? code
tomi_entity_FR = Repo.preload(tomi_entity_FR, [:entity])

item =
  Item.changeset(
    %Item{},
    %{
      product_uuid: tomi_entity.id,
      price: tomi_entity_FR.stock_price
      # num_of_treasury_stocks: tomi_entity_FR.num_of_treasury_stocks,
    }
  )
  |> Repo.insert!()

#? invoice_items => invoice => transaction => ticket => supul





# ? init T2 Manager for Korean capital market.
alias Demo.ABC.T2Pool
alias Demo.ABC.T2Item

t2_korea = T2Pool.changeset(%T2Pool{}) |> Repo.insert!

tomi_stock =
  T2Item.changeset(
    %T2Item{},
    %{
      entity_id: tomi_entity.id, 
      t2_pool_id: t2_korea.id, 
      stock_price: tomi_entity_FR.stock_price,
      amount: Decimal.from_float(45345.45),
      proportion_in_pool: Decimal.from_float(0.45), #? proportion in the pool
      proportion_in_market: Decimal.from_float(0.35), #? market capitalization ratio in Korean security market.
      fmv_gab: Decimal.from_float(15.35), #? difference between re_fmv and market price.
      }
  ) |> Repo.insert!


Repo.preload(tomi_stock, [:entity, :t2_pool])
t2_korea = Repo.preload(t2_korea, [:t2_items])


#? SECOND ~ FOURTH
# ? select stocks to purchase.
for x <- t2_korea.t2_items do
  
  #? calculate intrinsic_to_price value of each stock in the pool
  #? determine how much to buy for each selection
  #? buy the selected stock

end

#? FIFTH
# ? select stocks to sell.
for x <- t2_korea.t2_items do
  
  #? calculate intrinsic_to_price value of each stock in the pool
  #? determine how much to buy for each selection
  #? sell the selected stock

end
