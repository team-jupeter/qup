import Ecto.Query
import Ecto.Changeset
alias Demo.Repo


'''

SPECIAL USER == KOREA

'''
alias Demo.Accounts

{:ok, korea} = Accounts.create_user(%{
  type: "Nation",
  name: "South Korea", 
  username: "Korea", 
  password: "temppass",
  email: "korea@un",
  }) 

#? private and pulbic key of korea
korea_rsa_priv_key = ExPublicKey.load!("./keys/korea_private_key.pem")
korea_rsa_pub_key = ExPublicKey.load!("./keys/korea_public_key.pem")
   

'''

SUPUL

'''
#? GLOBAL SUPUL
alias Demo.Business
{:ok, global_supul} = Business.create_entity(korea, %{
  name: "글로벌 수풀", 
  pasword: "temppass",
  email: "golobal@un", 
  user_id: korea.id,
  gab_balance: Decimal.from_float(0.0),
  }) 

msg_serialized = Poison.encode!(global_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, global_supul} = Business.update_entity(global_supul, %{auth_code: signature}) 
   
#? KOREA SUPUL
{:ok, korea_supul} = Business.create_entity(korea, %{
  type: "Nation Supul",
  name: "한국 수풀", 
  pasword: "temppass",
  email: "korea@kr", 
  user_id: korea.id,
  global_supul_id: global_supul.id,
  gab_balance: Decimal.from_float(0.0),
  }) 

msg_serialized = Poison.encode!(korea_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, korea_supul} = Business.update_entity(korea_supul, %{auth_code: signature}) 
   
#? JEJUDO SUPUL
{:ok, jejudo_supul} = Business.create_entity(korea, %{
  type: "State Supul",
  name: "제주도 수풀", 
  pasword: "temppass",
  email: "jejudo@kr", 
  user_id: korea.id,
  nation_supul_id: korea_supul.id,
  gab_balance: Decimal.from_float(0.0),
  }) 

msg_serialized = Poison.encode!(jejudo_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, jejudo_supul} = Business.update_entity(jejudo_supul, %{auth_code: signature}) 
   
#? HANKYUNG SUPUL
{:ok, hankyung_supul} = Business.create_entity(korea, %{
  type: "Unit Supul",
  name: "한경 수풀", 
  pasword: "temppass",
  email: "hankyung@kr", 
  user_id: korea.id,
  state_supul_id: jejudo_supul.id,
  gab_balance: Decimal.from_float(0.0),
  }) 

msg_serialized = Poison.encode!(hankyung_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, hankyung_supul} = Business.update_entity(hankyung_supul, %{auth_code: signature}) 
   
#? HANLIM SUPUL
{:ok, hanlim_supul} = Business.create_entity(korea, %{
    name: "한림 수풀", 
    pasword: "temppass",
    email: "hanlim@kr", 
    user_id: korea.id,
    state_supul_id: jejudo_supul.id,
    gab_balance: Decimal.from_float(0.0),
    }) 

msg_serialized = Poison.encode!(hanlim_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, hanlim_supul} = Business.update_entity(hanlim_supul, %{auth_code: signature}) 
   


'''

HUMAN USER 
 
'''

#? A human being with nationality he or she claims.
{:ok, mr_hong} = Accounts.create_user(%{
  type: "Human",
  name: "홍 길동", 
  nationality: "South Korea", 
  username: "mr_hong", 
  password: "temppass",
  email: "hong_gil_dong@0001.kr",
  birth_date: ~N[1990-05-05 06:14:09],
  supul_id: hankyung_supul.id, 
  username: "mr_hong"
  })

#? Korea authorizes mr_hong as her citizen.
msg_serialized = Poison.encode!(mr_hong)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
{:ok, mr_hong} = Accounts.update_user(mr_hong, %{ssn: signature}) 
  
#? 성춘향   
{:ok, ms_sung} = Accounts.create_user(%{
  nationality: "South Korea", 
  name: "성 춘향", 
  username: "ms_sung", 
  email: "sung_chunhyang@82345.kr",
  password: "temppass",
  type: "Human",
  birth_date: ~N[2000-09-09 16:14:09],
  supul_id: hanlim_supul.id,
  username: "ms_sung"
  }) 

msg_serialized = Poison.encode!(ms_sung)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

# ms_sung = change(ms_sung) |> Ecto.Changeset.put_change(:ssn, signature) |> Repo.update!
{:ok, ms_sung} = Accounts.update_user(ms_sung, %{ssn: signature}) 

#? 임꺽정  
{:ok, mr_lim} = Accounts.create_user(%{
  nationality: "South Korea", 
  name: "임 꺽정", 
  username: "mr_lim", 
  password: "temppass",
  email: "limgeukjung@8889.kr",
  type: "Human",
  ssn: "5410051898822kr",
  birth_date: ~N[1970-11-11 09:14:09],
  supul_id: hankyung_supul.id,
  username: "mr_lim",
  }) 
    

msg_serialized = Poison.encode!(mr_lim)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# mr_lim = change(mr_lim) |> Ecto.Changeset.put_change(:ssn, signature) |> Repo.update!
{:ok, mr_lim} = Accounts.update_user(mr_lim, %{ssn: signature}) 

  



'''

ENTITIES

'''
#? 국세청 korea's Entity == a governmental organization  
{:ok, kts} = Business.create_entity(korea, %{
  type: "National Tax Infra",
  nationality: "South Korea", 
  name: "국세청 인프라", 
  project: "Korea Tax Service", 
  pasword: "temppass",
  supul_name: "한국",
  email: "kts@kr",
  user_id: korea.id,
  supul_id: korea_supul.id,
  gab_balance: Decimal.from_float(0.0),
  }) 


  #? Korea authorizes its governmental organizations.  
msg_serialized = Poison.encode!(kts)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# kts = change(kts) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, kts} = Business.update_entity(kts, %{auth_code: signature}) 


#? 국가 금융 인프라 Korea's Entity == a governmental organization  
{:ok, gab_korea} = Business.create_entity(korea, %{
  type: "National Monetary Infra",
  nationality: "South Korea", 
  name: "금융 인프라", 
  project: "GAB Korea", 
  supul_name: "한국",
  pasword: "temppass",
  email: "gab_korea@krd",
  user_id: korea.id,
  supul_id: korea_supul.id,
  gab_balance: Decimal.from_float(0.0),
  taxation_code: kts.id
  })

msg_serialized = Poison.encode!(gab_korea)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# gab_korea = change(gab_korea) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, gab_korea} = Business.update_entity(gab_korea, %{auth_code: signature}) 
{:ok, gab_korea} = Business.update_entity(gab_korea, %{taxation_id: kts.id}) 

#? 국가 교통물류 인프라 Korea's Entity == a governmental organization  
{:ok, gopang_korea} = Business.create_entity(korea, %{
  type: "National Logistics Infra",
  nationality: "South Korea", 
  name: "물류 인프라", 
  project: "Gopang",
  supul_name: "한국",
  pasword: "temppass",
  email: "gopang_korea@kr",
  user_id: korea.id,
  supul_id: korea_supul.id,
  gab_balance: Decimal.from_float(0.0),
  taxation_code: kts.id
  }) 

msg_serialized = Poison.encode!(gopang_korea)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# gopang_korea = change(gopang_korea) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, gopang_korea} = Business.update_entity(gopang_korea, %{auth_code: signature}) 


#? 시민 홍길동의 비즈니스 :: Hong's Entity
{:ok, hong_entity} = Business.create_entity(korea, %{
  type: "Unit Entity",
  nationality: "South Korea", 
  name: "Hong Entity", 
  supul_name: "한경면",
  pasword: "temppass",
  email: "hong@0001.kr", 
  entity_address: "제주시 한경면 20-1 해거름전망대",
  user_id: mr_hong.id,
  supul_id: hankyung_supul.id,
  gab_balance: Decimal.from_float(0.0),
  taxation_code: kts.id
  }) 

msg_serialized = Poison.encode!(hong_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, hong_entity} = Business.update_entity(hong_entity, %{auth_code: signature}) 

  
#? 시민 성춘향의 비즈니스 :: Sung's Entity
{:ok, sung_entity} = Business.create_entity(korea, %{
  type: "Unit Entity",
  name: "Sung Entity", 
  supul_name: "연동",
  email: "sung@0002.kr", 
  pasword: "temppass",
  entity_address: "제주시 연동 국수만찬",
  user_id: ms_sung.id,
  supul_id: hanlim_supul.id,
  gab_balance: Decimal.from_float(0.0),
  taxation_code: kts.id
  }) 

msg_serialized = Poison.encode!(sung_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, sung_entity} = Business.update_entity(sung_entity, %{auth_code: signature}) 
     

#? 시민 임꺽정의 비즈니스 :: Lim's Entity
{:ok, lim_entity} = Business.create_entity(korea, %{
  type: "Unit Entity",
  name: "Lim Entity", 
  supul_name: "안덕면",
  email: "lim@0001.kr", 
  pasword: "temppass",
  entity_address: "서귀포시 안덕면 77-1",
  user_id: mr_lim.id,
  supul_id: hankyung_supul.id,
  gab_balance: Decimal.from_float(0.0), 
  taxation_code: kts.id
  }) 

msg_serialized = Poison.encode!(lim_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# lim_entity = change(lim_entity) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, lim_entity} = Business.update_entity(lim_entity, %{auth_code: signature}) 
    

#? 시민 성춘향의 또 하나의 비즈니스 = Tomi Lunch Box
{:ok, tomi_entity} = Business.create_entity(korea, %{
  type: "Corporation",
  name: "Tomi Lunch Box", 
  project: "일반 법인", 
  supul_name: "한림읍",
  pasword: "temppass",
  email: "tomi@3532.kr", 
  entity_address: "제주시 한림읍 11-1",
  user_id: ms_sung.id,
  supul_id: hanlim_supul.id,
  gab_balance: Decimal.from_float(0.0),
  taxation_code: kts.id
  }) 

msg_serialized = Poison.encode!(tomi_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# tomi_entity = change(tomi_entity) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, tomi_entity} = Business.update_entity(tomi_entity, %{auth_code: signature}) 

'''

SET DEFAULT ENTITY OF EACH USER

'''
{:ok, mr_hong} = Accounts.update_user(mr_hong, %{default_entity: hong_entity.id}) 
{:ok, ms_sung} = Accounts.update_user(ms_sung, %{default_entity: sung_entity.id}) 
{:ok, mr_lim} = Accounts.update_user(mr_lim, %{default_entity: lim_entity.id}) 


'''

CRYPTO
Both users and entities should have private and public keys for future transactions.
'''

# ? openssl genrsa -out korea_private_key.pem 2048
# ? openssl rsa -in korea_private_key.pem -pubout > korea_public_key.pem
global_rsa_priv_key = ExPublicKey.load!("./keys/global_private_key.pem")
global_rsa_pub_key = ExPublicKey.load!("./keys/global_public_key.pem")

korea_rsa_priv_key = ExPublicKey.load!("./keys/korea_private_key.pem")
korea_rsa_pub_key = ExPublicKey.load!("./keys/korea_public_key.pem")

jejudo_rsa_priv_key = ExPublicKey.load!("./keys/jejudo_private_key.pem")
jejudo_rsa_pub_key = ExPublicKey.load!("./keys/jejudo_public_key.pem")

hankyung_rsa_priv_key = ExPublicKey.load!("./keys/hankyung_private_key.pem")
hankyung_rsa_pub_key = ExPublicKey.load!("./keys/hankyung_public_key.pem")
   
hanlim_rsa_priv_key = ExPublicKey.load!("./keys/hanlim_private_key.pem")
hanlim_rsa_pub_key = ExPublicKey.load!("./keys/hanlim_public_key.pem")

hong_entity_rsa_priv_key = ExPublicKey.load!("./keys/hong_entity_private_key.pem")
hong_entity_rsa_pub_key = ExPublicKey.load!("./keys/hong_entity_public_key.pem")

sung_entity_rsa_priv_key = ExPublicKey.load!("./keys/sung_entity_private_key.pem")
sung_entity_rsa_pub_key = ExPublicKey.load!("./keys/sung_entity_public_key.pem")

tomi_rsa_priv_key = ExPublicKey.load!("./keys/tomi_private_key.pem")
tomi_rsa_pub_key = ExPublicKey.load!("./keys/tomi_public_key.pem")

lim_entity_rsa_priv_key = ExPublicKey.load!("./keys/lim_entity_private_key.pem")
lim_entity_rsa_pub_key = ExPublicKey.load!("./keys/lim_entity_public_key.pem")

gopang_rsa_priv_key = ExPublicKey.load!("./keys/gopang_private_key.pem")
gopang_rsa_pub_key = ExPublicKey.load!("./keys/gopang_public_key.pem")

kts_rsa_priv_key = ExPublicKey.load!("./keys/kts_private_key.pem")
kts_rsa_pub_key = ExPublicKey.load!("./keys/kts_public_key.pem")



'''   

PUT_ASSOC 
user and entity

'''

#? 홍길동과 그의 비즈니스
mr_hong = Accounts.update_entities(mr_hong, [hong_entity])

#? 임꺽정과 그의 비즈니스
mr_lim = Accounts.update_entities(mr_lim, [lim_entity])

#? 성춘향과 그녀의 비즈니스들
ms_sung = Accounts.update_entities(ms_sung, [sung_entity, tomi_entity])

#? Corea와 정부 또는 공공 기관들
korea = Accounts.update_entities(korea, [
  kts, gab_korea, gopang_korea, global_supul, korea_supul, jejudo_supul, 
  hankyung_supul, hanlim_supul
])




'''   

Financial Reports

'''
# ? prepare financial statements for entities.
alias Demo.Reports.FinancialReport
alias Demo.Reports.IncomeStatement
alias Demo.Reports.CFStatement
alias Demo.Reports.BalanceSheet
alias Demo.Reports.EquityStatement

alias Demo.FinancialReports
alias Demo.IncomeStatements
alias Demo.CFStatements
alias Demo.BalanceSheets
alias Demo.EquityStatements

#? Financial Report
# gab_korea_FR =
#   FinancialReport.changeset(%FinancialReport{}, %{entity_id: gab_korea.id}) |> Repo.insert!()
{:ok, gopang_korea_FR} = FinancialReports.create_financial_report(gopang_korea, %{entity_id: gopang_korea.id}) 

{:ok, kts_FR} = FinancialReports.create_financial_report(kts, %{entity_id: kts.id}) 
{:ok, gab_korea_FR} = FinancialReports.create_financial_report(gab_korea, %{entity_id: gab_korea.id}) 

{:ok, hong_entity_FR} = FinancialReports.create_financial_report(hong_entity, %{entity_id: hong_entity.id}) 
{:ok, sung_entity_FR} = FinancialReports.create_financial_report(sung_entity, %{entity_id: sung_entity.id}) 
{:ok, lim_entity_FR} = FinancialReports.create_financial_report(lim_entity, %{entity_id: lim_entity.id}) 
{:ok, tomi_entity_FR} = FinancialReports.create_financial_report(tomi_entity, %{entity_id: tomi_entity.id}) 

{:ok, global_supul_FR} = FinancialReports.create_financial_report(global_supul, %{entity_id: global_supul.id}) 
{:ok, korea_supul_FR} = FinancialReports.create_financial_report(korea_supul, %{entity_id: korea_supul.id}) 
{:ok, jejudo_supul_FR} = FinancialReports.create_financial_report(jejudo_supul, %{entity_id: jejudo_supul.id}) 
{:ok, hankyung_supul_FR} = FinancialReports.create_financial_report(hankyung_supul, %{entity_id: hankyung_supul.id}) 
{:ok, hanlim_supul_FR} = FinancialReports.create_financial_report(hanlim_supul, %{entity_id: hanlim_supul.id}) 



#? Income Statement
{:ok, kts_is} = IncomeStatements.create_income_statement(kts, %{entity_id: kts.id}) 
{:ok, gab_korea_is} = IncomeStatements.create_income_statement(gab_korea, %{entity_id: gab_korea.id}) 
{:ok, gopang_korea_is} = IncomeStatements.create_income_statement(gopang_korea, %{entity_id: gopang_korea.id}) 

{:ok, hong_entity_is} = IncomeStatements.create_income_statement(hong_entity, %{entity_id: hong_entity.id}) 
{:ok, sung_entity_is} = IncomeStatements.create_income_statement(sung_entity, %{entity_id: sung_entity.id}) 
{:ok, lim_entity_is} = IncomeStatements.create_income_statement(lim_entity, %{entity_id: lim_entity.id}) 
{:ok, tomi_entity_is} = IncomeStatements.create_income_statement(tomi_entity, %{entity_id: tomi_entity.id}) 

{:ok, global_supul_IS} = IncomeStatements.create_income_statement(global_supul, %{entity_id: global_supul.id}) 
{:ok, korea_supul_IS} = IncomeStatements.create_income_statement(korea_supul, %{entity_id: korea_supul.id}) 
{:ok, jejudo_supul_IS} = IncomeStatements.create_income_statement(jejudo_supul, %{entity_id: jejudo_supul.id}) 
{:ok, hankyung_supul_IS} = IncomeStatements.create_income_statement(hankyung_supul, %{entity_id: hankyung_supul.id}) 
{:ok, hanlim_supul_IS} = IncomeStatements.create_income_statement(hanlim_supul, %{entity_id: hanlim_supul.id}) 


#? Balance Sheet
alias Demo.ABC.T1

#? 국가 물류 인프라
{:ok, gopang_korea_BS} = BalanceSheets.create_balance_sheet(gopang_korea, %{ 
    gab_balance: Decimal.from_float(0.0),
    entity_name: gopang_korea.name,
    cash: Decimal.from_float(0.0),
  })
  
new_t1s = %{t1s: %T1{
  input_name: gab_korea.name, 
  input_id: gab_korea.id, 
  output_name: gopang_korea.name, 
  output_id: gopang_korea.id, 
  amount: Decimal.from_float(0.0)}}

BalanceSheets.add_t1s(gopang_korea_BS, new_t1s)  

#? 국가 금융 인프라
{:ok, gab_korea_BS} = BalanceSheets.create_balance_sheet(gab_korea, %{
      entity_name: gab_korea.name,
      gab_balance: Decimal.from_float(0.0),
      cash: Decimal.from_float(0.00),
    }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: gab_korea.name, 
  output_id: gab_korea.id, 
  amount: Decimal.from_float(0.0),
  }}

BalanceSheets.add_t1s(gab_korea_BS, new_t1s)  

#? 반자동 국세청
{:ok, kts_BS} = BalanceSheets.create_balance_sheet(kts, %{
  entity_name: kts.name,
  cash: Decimal.from_float(0.0),
  gab_balance: Decimal.from_float(0.0),
  })
 
new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: kts.name, 
  output_id: kts.id, 
  amount: Decimal.from_float(0.0),
  }}

BalanceSheets.add_t1s(kts_BS, new_t1s)  

#? 홍길동 1인 법인
{:ok, hong_entity_BS} = BalanceSheets.create_balance_sheet(hong_entity, %{
  entity_name: hong_entity.name,
  cash: Decimal.from_float(50_000.0),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: hong_entity.name, 
  output_id: hong_entity.id, 
  amount: Decimal.from_float(0.0),
  }}

BalanceSheets.add_t1s(hong_entity_BS, new_t1s)  

#? 임꺽정 1인 법인
{:ok, lim_entity_BS} = BalanceSheets.create_balance_sheet(lim_entity, %{
  entity_name: lim_entity.name,
  cash: Decimal.from_float(50_000.00),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: lim_entity.name, 
  output_id: lim_entity.id, 
  amount: Decimal.from_float(0.0),
  }}

BalanceSheets.add_t1s(lim_entity_BS, new_t1s)  

#? 성춘향 1인 법인
{:ok, sung_entity_BS} = BalanceSheets.create_balance_sheet(sung_entity, %{
  entity_name: sung_entity.name,
  cash: Decimal.from_float(50_000.00),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: sung_entity.name, 
  output_id: sung_entity.id, 
  amount: Decimal.from_float(0.0),
  }}

BalanceSheets.add_t1s(sung_entity_BS, new_t1s)  

#? 토미 도시락 일반 법인
{:ok, tomi_entity_BS} = BalanceSheets.create_balance_sheet(tomi_entity, %{
  entity_name: tomi_entity.name,
  cash: Decimal.from_float(0.0),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: tomi_entity.name, 
  output_id: tomi_entity.id, 
  amount: Decimal.from_float(0.0),
  }}

tomi_entity_BS = BalanceSheets.add_t1s(tomi_entity_BS, new_t1s)  


#? Global Supul
{:ok, global_supul_BS} = BalanceSheets.create_balance_sheet(global_supul, %{
  entity_name: global_supul.name,
  cash: Decimal.from_float(0.0),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: global_supul.name, 
  output_id: global_supul.id, 
  amount: Decimal.from_float(0.0),
  }}

global_supul_BS = BalanceSheets.add_t1s(global_supul_BS, new_t1s)  

    
#? Korea Supul
{:ok, korea_supul_BS} = BalanceSheets.create_balance_sheet(korea_supul, %{
  entity_name: korea_supul.name,
  cash: Decimal.from_float(0.0),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: korea_supul.name, 
  output_id: korea_supul.id, 
  amount: Decimal.from_float(0.0),
  }}

korea_supul_BS = BalanceSheets.add_t1s(korea_supul_BS, new_t1s)  

    

#? Cash Flow Statement
# gab_korea_CF =
#   IncomeStatement.changeset(%IncomeStatement{}, %{entity_id: gab_korea.id}) |> Repo.insert!()
{:ok, gab_korea_CF} = CFStatements.create_cf_statement(gab_korea, %{entity_id: gab_korea.id}) 
{:ok, kts_CF} = CFStatements.create_cf_statement(kts, %{entity_id: kts.id}) 
{:ok, gopang_korea_CF} = CFStatements.create_cf_statement(gopang_korea, %{entity_id: gopang_korea.id}) 

{:ok, hong_entity_CF} = CFStatements.create_cf_statement(hong_entity, %{entity_id: hong_entity.id}) 
{:ok, sung_entity_CF} = CFStatements.create_cf_statement(sung_entity, %{entity_id: sung_entity.id}) 
{:ok, tomi_entity_CF} = CFStatements.create_cf_statement(tomi_entity, %{entity_id: tomi_entity.id}) 
{:ok, lim_entity_CF} = CFStatements.create_cf_statement(lim_entity, %{entity_id: lim_entity.id}) 

{:ok, global_supul_CF} = CFStatements.create_cf_statement(global_supul, %{entity_id: global_supul.id}) 
{:ok, korea_supul_CF} = CFStatements.create_cf_statement(korea_supul, %{entity_id: korea_supul.id}) 
{:ok, jejudo_supul_CF} = CFStatements.create_cf_statement(jejudo_supul, %{entity_id: jejudo_supul.id}) 
{:ok, hankyung_supul_CF} = CFStatements.create_cf_statement(hankyung_supul, %{entity_id: hankyung_supul.id}) 
{:ok, hanlim_supul_CF} = CFStatements.create_cf_statement(hanlim_supul, %{entity_id: hanlim_supul.id}) 



#? Equity Statement
# kts_ES =
#   EquityStatement.changeset(%EquityStatement{}, %{entity_id: kts.id}) |> Repo.insert!()
{:ok, kts_ES} = EquityStatements.create_equity_statement(kts, %{entity_id: kts.id}) 
{:ok, gab_korea_ES} = EquityStatements.create_equity_statement(gab_korea, %{entity_id: gab_korea.id}) 
{:ok, gopang_korea_ES} = EquityStatements.create_equity_statement(gopang_korea, %{entity_id: gopang_korea.id}) 

{:ok, hong_entity_ES} = EquityStatements.create_equity_statement(hong_entity, %{entity_id: hong_entity.id}) 
{:ok, sung_entity_ES} = EquityStatements.create_equity_statement(sung_entity, %{entity_id: sung_entity.id}) 
{:ok, lim_entity_ES} = EquityStatements.create_equity_statement(lim_entity, %{entity_id: lim_entity.id}) 
{:ok, tomi_entity_ES} = EquityStatements.create_equity_statement(tomi_entity, %{entity_id: tomi_entity.id}) 

{:ok, global_supul_ES} = EquityStatements.create_equity_statement(global_supul, %{entity_id: global_supul.id}) 
{:ok, korea_supul_ES} = EquityStatements.create_equity_statement(korea_supul, %{entity_id: korea_supul.id}) 
{:ok, jejudo_supul_ES} = EquityStatements.create_equity_statement(jejudo_supul, %{entity_id: jejudo_supul.id}) 
{:ok, hankyung_supul_ES} = EquityStatements.create_equity_statement(hankyung_supul, %{entity_id: hankyung_supul.id}) 
{:ok, hanlim_supul_ES} = EquityStatements.create_equity_statement(hanlim_supul, %{entity_id: hanlim_supul.id}) 





'''
TRANSACTION 1

Transaction between gab_korea_entity and hong_entity.

The price of ABC T1, T2, T3 will be updated every second.
The code below is hard coded. We need write codes for invoice_items with only one item.
'''
# alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}
# alias Demo.Business.Product
alias Demo.Business


#? From now on, let's write invoice for trade between mr_hong and gab_korea.
#? First, let "krw" a product of hong_entity
{:ok, krw} = Business.create_product(hong_entity, %{
  name: "KRW", 
  seller_id: hong_entity.id,
  seller_name: hong_entity.name,
  seller_supul_name: "한림 수플",
  seller_supul_id: hanlim_supul.id,
  price: Decimal.from_float(0.0012),
  }) 
  
# hong_entity = Entity.changeset_update_products(hong_entity, [krw])

#? prepare transaction between hong_entity and gab_korea. gab_korea will buy krw from hong_entity. 
#? Remember, in a transaction, the one paying ABC is buyer, and the other receiving ABC is seller. 

#? There can be more than one items in an invoice like 짜장 2, 짬뽕 1, 탕수육 1 ...
invoice_items = []

# invoice_item = InvoiceItem.changeset(%InvoiceItem{}, %{item_name: "KRW", product_id: krw.id, price: krw.price, quantity: 20000}) |> Repo.insert!
alias Demo.InvoiceItems
{:ok, invoice_item} = InvoiceItems.create_invoice_item(%{
  "product_id" => product.id,
  "quantity" => 20000})

invoice_items = [invoice_item | invoice_items]


alias Demo.Invoices
attrs = %{
  invoice_items: invoice_items
}
{:ok, invoice} = Invoices.create_invoice(attrs)


alias Demo.Transactions
{:ok, transaction} = Transactions.create_transaction(hong_entity, invoice, hong_entity_rsa_priv_key, tomi_rsa_priv_key)

payload(transaction, buyer_rsa_priv_key, sender_rsa_priv_key)



'''

BIZ_CATEGORY & GPC_CODE

'''
alias Demo.Business
alias Demo.Business.BizCategory

for category <- [%{name: "한식 일반 음식점업", standard: "한국표준산업분류표", code: "56111"}, %{name: "김밥 및 기타 간이 음식점업", standard: "한국표준산업분류표", code: "56194"}] do
  Business.create_biz_category!(category)
end


alias Demo.Business.GPCCode
# 분식 = GPCCode.changeset(%GPCCode{name: "분식", code: "345445", standard: "GTIN"}) |> Repo.insert!
# 한식 = GPCCode.changeset(%GPCCode{name: "한식", code: "345446", standard: "GTIN"}) |> Repo.insert!
{:ok, 분식} = Business.create_GPCCode(%{name: "분식", code: "345445", standard: "GTIN"}) 
{:ok, 한식} = Business.create_GPCCode(%{name: "한식", code: "345446", standard: "GTIN"}) 


alias Demo.Business.Product
#? 토미 김밥의 상품
# 김밥 = Product.changeset(%Product{name: "김밥", gpc_code_id: 분식.id, price: 1.0}) |> Repo.insert!
{:ok, 김밥} = Business.create_product(tomi_entity, %{
  name: "김밥", 
  gpc_code_id: 분식.id, 
  price: 1.0
  }) 
{:ok, 떡볶이} =  Business.create_product(tomi_entity, %{name: "떡볶이", gpc_code_id: 분식.id, price: 1.5}) 
{:ok, 우동} = Business.create_product(tomi_entity, %{name: "우동", gpc_code_id: 분식.id, price: 1.5}) 


#? 임꺽정 산채의 상품
{:ok, 한정식} = Business.create_product(lim_entity, %{name: "한정식", gpc_code_id: 한식.id, price: 5.0})
{:ok, 육개장} = Business.create_product(lim_entity, %{name: "육개장", gpc_code_id: 한식.id, price: 3.5})
{:ok, 갈비탕} = Business.create_product(lim_entity, %{name: "갈비탕", gpc_code_id: 한식.id, price: 3.5})


# #? 토미 김밥
# tomi_entity = Entity.changeset_update_products(tomi_entity, [김밥, 떡볶이, 우동])

# #? 임꺽정의 산채 한정식
# lim_entity = Entity.changeset_update_products(lim_entity, [한정식, 육개장, 갈비탕])


alias Demo.Multimedia
# 한정식_video = Video.changeset(%Video{title: "산채 한정식", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 한정식.id, description: "엄청 맛있데요. 글쎄..."}) |> Repo.insert!
{:ok, 한정식_video} = Multimedia.create_video(한정식, %{title: "산채 한정식", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 한정식.id, description: "엄청 맛있데요. 글쎄..."})
{:ok, 육개장_video} = Multimedia.create_video(육개장, %{title: "육개장", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 육개장.id, description: "엄청 맛있데요. 글쎄..."})
{:ok, 갈비탕_video} = Multimedia.create_video(갈비탕, %{title: "갈비탕", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 갈비탕.id, description: "엄청 맛있데요. 글쎄..."})

{:ok, 김밥_video} = Multimedia.create_video(김밥, %{title: "김밥", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 김밥.id, description: "엄청 맛있데요. 글쎄..."})
{:ok, 떡볶이_video} = Multimedia.create_video(떡볶이, %{title: "떡볶이", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 떡볶이.id, description: "엄청 맛있데요. 글쎄..."})
{:ok, 우동_video} = Multimedia.create_video(우동, %{title: "우동", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 우동.id, description: "엄청 맛있데요. 글쎄..."})



'''
TRANSACTION 2
Transaction between hong_entity and tomi_entity
'''

#? write invoice for trade between mr_hong and gab_korea.
# item_1 = Item.changeset(%Item{}, %{gpc_code: "ABCDE11133", category: "Food", name: "김밥", price: Decimal.from_float(0.01)}) |> Repo.insert!
# item_2 = Item.changeset(%Item{}, %{gpc_code: "ABCDE11134", category: "Food", name: "떡볶이", price: Decimal.from_float(0.02)}) |> Repo.insert!
# invoice_items = [%{item_id: item_1.id, quantity: 3}, %{item_id: item_2.id, quantity: 3}]
alias Demo.Business.InvoiceItem
alias Demo.InvoiceItems
alias Demo.Invoices
{:ok, product_1} = Business.create_product(tomi_entity, %{gpc_code: "ABCDE11133", category: "Food", name: "김밥", price: Decimal.from_float(0.01)}) 
{:ok, product_2} = Business.create_product(tomi_entity, %{gpc_code: "ABCDE11134", category: "Food", name: "떡볶이", price: Decimal.from_float(0.02)}) 

{:ok, invoice_item_1} = InvoiceItems.create_invoice_item(%{product_id: product_1.id, price: product_1.price, quantity: 3})
{:ok, invoice_item_2} = InvoiceItems.create_invoice_item(%{product_id: product_2.id, price: product_2.price, quantity: 3})

invoice_items = [invoice_item_1, invoice_item_2]

params = %{
  "buyer" => %{"main_id" => hong_entity.id, "main_name" => hong_entity.name},
  "seller" => %{"main_id" => tomi_entity.id, "main_name" => tomi_entity.name},
  "invoice_items" => invoice_items,
}

#? invoice => transaction => supul (1) update financial reports, (2) archieve, (3) openhash
invoice = Invoices.create_invoice(params)
transaction = Transactions.create_transaction(tomi_entity, invoice, hong_entity_rsa_priv_key, tomi_rsa_priv_key)













'''

Third, the mulet of supul, state_supul, korea_supul and global_supul openhashes the unserialized message. 

'''

#? Supul Mulet 
#? pretend transmit the message...
#? pretend receive the message...
hankyung_mulet = Ecto.build_assoc(hankyung_supul, :mulet, %{current_hash: hankyung_supul.id}) 

incoming_hash = :crypto.hash(:sha256, payload) \
  |> Base.encode16() \
  |> String.downcase()
hankyung_mulet = Mulet.changeset(hankyung_mulet, %{incoming_hash: incoming_hash})

#? send every 10th payload to the state_supul of supul.

#? StateSupul Mulet 
#? pretend transmit the message...
#? pretend receive the message...
jejudo_mulet = Ecto.build_assoc(jejudo_supul, :mulet, %{current_hash: jejudo_supul.id}) 
jejudo_mulet = Mulet.changeset(jejudo_mulet, %{incoming_hash: incoming_hash})

#? send every 100th payload to the nation_supul of sate_supul.
korea_mulet = Ecto.build_assoc(korea_supul, :mulet, %{current_hash: korea_supul.id}) 
korea_mulet = Mulet.changeset(korea_mulet, %{incoming_hash: incoming_hash})

#? send every 10000th payload to the global_supul of sate_supul.
global_mulet = Ecto.build_assoc(global_supul, :mulet, %{current_hash: global_supul.id}) 
global_mulet = Mulet.changeset(global_mulet, %{incoming_hash: incoming_hash})

#? send every 1000th payload to the supuls of the world.
hankyung_mulet = Mulet.changeset(hankyung_mulet, %{incoming_hash: incoming_hash})






'''

GOPANG

'''
#? assume the gopang of hankyung has calcuated the road sections to be inclued in the route.
alias Demo.Gopangs.RoadSectionEmbed

road_sections = [
    %RoadSectionEmbed{
    section_uid: "qt2453",
    a_spot: %{lagitude: 35.89421911, longitude: 139.94637467, altitude: 39.9463},
    b_spot: %{lagitude: 35.8925543, longitude: 139.94626565, altitude: 34.4567}
    },
    %RoadSectionEmbed{
    section_uid: "qt2454",
    a_spot: %{lagitude: 35.89421425, longitude: 139.946453, altitude: 32.9443},
    b_spot: %{lagitude: 35.892552, longitude: 139.9462665, altitude: 32.455}
    },
    %RoadSectionEmbed{
    section_uid: "qt2456",
    a_spot: %{lagitude: 35.8942165, longitude: 139.9463745, altitude: 36.944},
    b_spot: %{lagitude: 35.8925523, longitude: 139.94626563, altitude: 37.45434}
    },
]


# ? build_assock: allocate a car or cars to the ticket
alias Demo.Cars.Car
car_1 = Car.changeset(%Car{}, %{name: "은하철도_999"}) |> Repo.insert!()
ticket = Ecto.build_assoc(car_1, :tickets, ticket)

#? put_embed
ticket =
  change(ticket) \
  |> Ecto.Changeset.put_embed(:road_sections, road_sections) \
  |> Repo.update!()



'''

SHOW TIME !!! 👻 👻 👻 👻 👻 👻

'''
#? Code machine learning module here !!!!

ticket = change(ticket) \
|> Ecto.Changeset.put_embed(:deliverybox, %{
    code: "adfs3424",
    status: "moving",
    current_location: %{latitude: "위도", longitude: "경도"}}) \
|> Repo.update!()



alias Demo.Gopangs.RouteEmbed
alias Demo.Gopangs.RoadSectionEmbed

route = %RouteEmbed{
    departure_spot: %{lagitude: 35.89421911, longitude: 139.94637467, altitude: 39.9463},
    arrival_spot: %{lagitude: 35.8925543, longitude: 139.94626565, altitude: 34.4567}
  }
  
ticket =
  change(ticket) \
  |> Ecto.Changeset.put_embed(:route, route) \
  |> Repo.update!()



  
Repo.one from u in User,
select: count(u.id),
where: ilike(u.username, "s%") or ilike(u.username, "m%")

users_count = from u in User, select: count(u.id)
j_users = from u in users_count, where: ilike(u.username, ^"%h%")

Repo.one j_users

