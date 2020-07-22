import Ecto.Query
import Ecto.Changeset
alias Demo.Repo
 
 
'''

SPECIAL USER == KOREA

'''
alias Demo.Nations
{:ok, korea} = Nations.create_nation(%{
  name: "South Korea", 
  }) 

#? private and pulbic key of korea
korea_rsa_priv_key = ExPublicKey.load!("./keys/korea_private_key.pem")
korea_rsa_pub_key = ExPublicKey.load!("./keys/korea_public_key.pem")
   
alias Demo.Accounts


{:ok, corea} = Accounts.create_user(%{
  name: "COREA", 
  username: "corea", 
  password: "p",
  email: "corea@un",
  family_code: nil,
  supul: nil, 
  nation: korea,
  }) 

# #? private and pulbic key of korea
# korea_rsa_priv_key = ExPublicKey.load!("./keys/korea_private_key.pem")
# korea_rsa_pub_key = ExPublicKey.load!("./keys/korea_public_key.pem")
   



'''

SUPUL

'''
#? GLOBAL SUPUL
alias Demo.GlobalSupuls
alias Demo.NationSupuls
alias Demo.StateSupuls
alias Demo.Supuls

{:ok, global_supul} = GlobalSupuls.create_global_supul(%{
  name: "글로벌 수풀", 
  pasword: "p",
  email: "golobal@un", 
  gab_balance: Decimal.from_float(0.0),
  }) 

msg_serialized = Poison.encode!(global_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, global_supul} = GlobalSupuls.update_global_supul(global_supul, %{auth_code: signature}) 
   
#? KOREA SUPUL
{:ok, korea_supul} = NationSupuls.create_nation_supul(%{
  type: "Nation Supul", 
  nation_supul_code: "82",
  name: "한국 수풀", 
  global_supul: global_supul, 
  user_id: corea.id,
  global_supul_id: global_supul.id,
  gab_balance: Decimal.from_float(0.0),
  }) 

msg_serialized = Poison.encode!(korea_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, korea_supul} = NationSupuls.update_nation_supul(korea_supul, %{auth_code: signature}) 
   
#? JEJUDO SUPUL
{:ok, jejudo_supul} = StateSupuls.create_state_supul(%{
  name: "제주도 수풀", 
  type: "State Supul", 
  state_supul_code: "8213",
  nation_supul: korea_supul, 
  gab_balance: Decimal.from_float(0.0),
  }) 

msg_serialized = Poison.encode!(jejudo_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, jejudo_supul} = StateSupuls.update_state_supul(jejudo_supul, %{auth_code: signature}) 
   
#? HANKYUNG SUPUL
{:ok, hankyung_supul} = Supuls.create_supul(%{
  name: "한경 수풀", 
  state_name: "제주도", 
  nation_name: "한국",
  type: "Unit Supul", 
  supul_code: "821311",
  state_supul: jejudo_supul,
  gab_balance: Decimal.from_float(0.0),
  current_hash: "hankyung"
  }) 

msg_serialized = Poison.encode!(hankyung_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, hankyung_supul} = Supuls.update_supul(hankyung_supul, %{auth_code: signature}) 
   
#? HANLIM SUPUL
{:ok, hanlim_supul} = Supuls.create_supul(%{ 
    name: "한림 수풀", 
    state_name: "제주도", 
    nation_name: "한국",
    type: "Unit Supul", 
    supul_code: "821312",
    state_supul: jejudo_supul,
    gab_balance: Decimal.from_float(0.0),
    current_hash: "hanlim"
    }) 

msg_serialized = Poison.encode!(hanlim_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, hanlim_supul} = Supuls.update_supul(hanlim_supul, %{auth_code: signature}) 
   
#? SEOGUIPO SUPUL
{:ok, seoguipo_supul} = Supuls.create_supul(%{ 
    name: "서귀포 수풀", 
    state_name: "제주도", 
    nation_name: "한국",
    type: "Unit Supul", 
    supul_code: "821313",
    state_supul: jejudo_supul,
    gab_balance: Decimal.from_float(0.0),
    current_hash: "seoguipo"
    }) 

msg_serialized = Poison.encode!(seoguipo_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, seoguipo_supul} = Supuls.update_supul(seoguipo_supul, %{auth_code: signature}) 
   


'''

HUMAN USER 
 
'''
#? A human being with nationality he or she claims.
{:ok, mr_hong} = Accounts.create_user(%{
  type: "Human",
  name: "홍길동", 
  nation: korea,
  supul: hankyung_supul, 
  username: "mr_hong", 
  password: "p",
  nationality: "한국",
  supul_name: "한경면",
  family_code: nil, 
  email: "hong@0000.kr",
  birth_date: ~N[1990-05-05 06:14:09],
  username: "mr_hong"
  })

#? Korea authorizes mr_hong as her citizen.
msg_serialized = Poison.encode!(mr_hong)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
{:ok, mr_hong} = Accounts.update_user(mr_hong, %{auth_code: signature}) 
  
#? 성춘향   
{:ok, ms_sung} = Accounts.create_user(%{
  name: "성춘향", 
  nation: korea, 
  supul: hanlim_supul,
  username: "ms_sung", 
  family_code: nil, 
  nationality: "한국",
  supul_name: "한림읍",
  email: "sung@0000.kr",
  password: "p",
  type: "Human",
  birth_date: ~N[2000-09-09 16:14:09],
  username: "ms_sung"
  }) 

msg_serialized = Poison.encode!(ms_sung)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, ms_sung} = Accounts.update_user(ms_sung, %{auth_code: signature}) 

#? 임꺽정  
{:ok, mr_lim} = Accounts.create_user(%{
  name: "임꺽정", 
  nation: korea,
  supul: hankyung_supul,
  username: "mr_lim", 
  password: "p",
  family_code: nil, 
  nationality: "한국",
  supul_name: "한경면",
  email: "lim@0000.kr",
  type: "Human",
  auth_code: "5410051898822kr",
  birth_date: ~N[1970-11-11 09:14:09],
  username: "mr_lim",
  }) 
    

msg_serialized = Poison.encode!(mr_lim)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, mr_lim} = Accounts.update_user(mr_lim, %{auth_code: signature}) 

  
#? A human being with nationality he or she claims.
{:ok, mr_lee} = Accounts.create_user(%{
  type: "Human",
  name: "이몽룡", 
  nation: korea,
  supul: seoguipo_supul, 
  username: "mr_lee", 
  password: "p",
  nationality: "한국",
  supul_name: "서귀포",
  email: "lee@0000.kr",
  birth_date: ~N[2000-05-05 06:14:09],
  family_code: nil, 
  username: "mr_lee"
  })

#? Korea authorizes mr_lee as her citizen.
msg_serialized = Poison.encode!(mr_lee)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
{:ok, mr_lee} = Accounts.update_user(mr_lee, %{auth_code: signature}) 

'''

CRYPTO
Both users and entities should have private and public keys for future transactions.
'''

# ? openssl genrsa -outlee_private_key.pem 2048
# ? openssl rsa -inlee_private_key.pem -pubout >lee_public_key.pem
lee_priv_key = ExPublicKey.load!("./keys/lee_private_key.pem")
lee_pub_key = ExPublicKey.load!("./keys/lee_public_key.pem")

sung_priv_key = ExPublicKey.load!("./keys/sung_private_key.pem")
sung_pub_key = ExPublicKey.load!("./keys/sung_public_key.pem")


'''

ENTITIES & OTHERS

'''
alias Demo.Taxations

#? 국세청 korea's Entity == a governmental organization  
{:ok, kts} = Taxations.create_taxation(%{
  name: "Korea Tax Service", 
  nation: korea,
  nation_supul: korea_supul,
  supul_anme: "korea_supul",
  }) 
  
  
  #? Korea authorizes its governmental organizations.  
  msg_serialized = Poison.encode!(kts)
  ts = DateTime.utc_now() |> DateTime.to_unix()
  ts_msg_serialized = "#{ts}|#{msg_serialized}"
  {:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
  signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
  # kts = change(kts) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
  {:ok, kts} = Taxations.update_taxation(kts, %{auth_code: signature}) 
  
  
alias Demo.Entities

#? 국가 금융 인프라 Korea's Entity == a governmental organization  
{:ok, gab_korea} = Entities.create_public_entity(%{
  type: "National Monetary Infra",
  name: "GAB Korea", 
  user: corea, 
  nation: korea,
  nation_supul: korea_supul, 
  project: "반자동 금융 인프라", 
  supul_name: "한국",
  pasword: "temppass",
  email: "gab_korea@krd",
  gab_balance: Decimal.from_float(1000.0),
  })

msg_serialized = Poison.encode!(gab_korea)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# gab_korea = change(gab_korea) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, gab_korea} = Entities.update_entity(gab_korea, %{auth_code: signature}) 

#? 국가 교통물류 인프라 Korea's Entity == a governmental organization  
{:ok, gopang_korea} = Entities.create_public_entity(%{
  type: "National Logistics Infra",
  name: "Gopang", 
  user: corea, 
  nation: korea,
  nation_supul: korea_supul, 
  project: "반자동 물류 인프라",
  supul_name: "한국",
  pasword: "temppass",
  email: "gopang_korea@kr",
  gab_balance: Decimal.from_float(0.0),
  }) 

msg_serialized = Poison.encode!(gopang_korea)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# gopang_korea = change(gopang_korea) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, gopang_korea} = Entities.update_entity(gopang_korea, %{auth_code: signature}) 


#? 시민 홍길동의 비즈니스 :: Hong's Entity
{:ok, hong_entity} = Entities.create_default_entity(mr_hong, %{
  type: "Unit Entity",
  name: "Hong Entity", 
  user: mr_hong, 
  nation: korea,
  supul: hankyung_supul, 
  taxation: kts,
  supul_name: "한경면",
  pasword: "temppass",
  email: "hong@0000.kr", 
  entity_address: "제주시 한경면 20-1 해거름전망대",
  gab_balance: Decimal.from_float(0.0),
  }) 

msg_serialized = Poison.encode!(hong_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, hong_entity} = Entities.update_entity(hong_entity, %{auth_code: signature}) 

  
#? 시민 성춘향의 비즈니스 :: Sung's Entity
{:ok, sung_entity} = Entities.create_default_entity(ms_sung, %{
  type: "Unit Entity",
  name: "Sung Entity", 
  user: ms_sung,
  supul: hanlim_supul,
  nation: korea,
  taxation: kts,
  supul_name: "한림",
  email: "sung@0000.kr", 
  pasword: "temppass",
  gab_balance: Decimal.from_float(0.0),
  }) 

msg_serialized = Poison.encode!(sung_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, sung_entity} = Entities.update_entity(sung_entity, %{auth_code: signature}) 
     

#? 시민 임꺽정의 비즈니스 :: Lim's Entity
{:ok, lim_entity} = Entities.create_default_entity(mr_lim, %{
  type: "Unit Entity",
  name: "Lim Entity", 
  user: mr_lim,
  nation: korea,
  supul: hanlim_supul,
  taxation: kts,
  supul_name: "한경면",
  email: "lim@0000.kr", 
  pasword: "temppass",
  user_id: mr_lim.id,
  gab_balance: Decimal.from_float(0.0), 
  }) 

msg_serialized = Poison.encode!(lim_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# lim_entity = change(lim_entity) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, lim_entity} = Entities.update_entity(lim_entity, %{auth_code: signature}) 
    
#? 시민 이몽룡의 비즈니스 :: Lee's Entity
{:ok, lee_entity} = Entities.create_default_entity(mr_lee, %{
  type: "Unit Entity",
  name: "Lee Entity", 
  user: mr_lee,
  nation: korea,
  supul: seoguipo_supul,
  taxation: kts,
  supul_name: "서귀포",
  email: "lee@0000.kr", 
  pasword: "temppass",
  user_id: mr_lee.id,
  gab_balance: Decimal.from_float(0.0), 
  }) 

msg_serialized = Poison.encode!(lee_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# lee_entity = change(lim_entity) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, lee_entity} = Entities.update_entity(lee_entity, %{auth_code: signature}) 
    

#? 시민 성춘향의 또 하나의 비즈니스 = Tomi Lunch Box
{:ok, tomi_entity} = Entities.create_private_entity(%{
  type: "Corporation",
  name: "Tomi Lunch Box", 
  user: ms_sung,
  supul: hanlim_supul,
  nation: korea,
  taxation: kts,
  project: "일반 법인", 
  supul_name: "한림읍",
  pasword: "temppass",
  email: "tomi@3532.kr", 
  entity_address: "제주시 한림읍 11-1",
  gab_balance: Decimal.from_float(0.0),
  }) 

msg_serialized = Poison.encode!(tomi_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# tomi_entity = change(tomi_entity) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, tomi_entity} = Entities.update_entity(tomi_entity, %{auth_code: signature}) 

'''
SET DEFAULT ENTITY OF EACH USER
'''
{:ok, mr_hong} = Accounts.update_user(mr_hong, %{default_entity_id: hong_entity.id, default_entity_name: "hong_entity"}) 
{:ok, ms_sung} = Accounts.update_user(ms_sung, %{default_entity_id: sung_entity.id, default_entity_name: "sung_entity"}) 
{:ok, mr_lim} = Accounts.update_user(mr_lim, %{default_entity_id: lim_entity.id, default_entity_name: "lim_entity"}) 
{:ok, mr_lee} = Accounts.update_user(mr_lee, %{default_entity_id: lee_entity.id, default_entity_name: "lee_entity"}) 


'''
EVENT
ms_sung married mr_lee.
''' 

#? a new family
alias Demo.Weddings
{:ok, lee_family} = Weddings.create_wedding(%{
  type: "wedding", bride_name: "이몽룡", bride_email: mr_lee.email, 
  groom_name: "성춘향", groom_email: ms_sung.email
  }, lee_priv_key, sung_priv_key)



'''
TEST
wedding = Repo.preload(lee_family, :wedding).wedding
openhashes = Repo.preload(wedding, :openhashes).openhashes
'''

#? Korea authorizeslee_family as her citizen.
msg_serialized = Poison.encode!(lee_family)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
{:ok,lee_family} = Families.update_family(lee_family, %{auth_code: signature}) 
  
#? add ms_sung to the house member of the lee_family.
Families.update_family_members(lee_family, %{
  husband: mr_lee.email, wife: ms_sung.email}, 
  house_holder_rsa_priv_key:lee_rsa_priv_key, new_member_rsa_priv_key: sung_rsa_priv_key)


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
{:ok, kts_FR} = FinancialReports.create_tax_financial_report(%{taxation: kts, nation: korea, nation_supul: korea_supul}) 
{:ok, gopang_korea_FR} = FinancialReports.create_public_financial_report(%{entity: gopang_korea, nation_supul: korea_supul}) 
{:ok, gab_korea_FR} = FinancialReports.create_public_financial_report(%{entity: gab_korea, nation_supul: korea_supul}) 

{:ok, hong_entity_FR} = FinancialReports.create_financial_report(%{entity: hong_entity, supul: hankyung_supul}) 
{:ok, sung_entity_FR} = FinancialReports.create_financial_report(%{entity: sung_entity, supul: hanlim_supul}) 
{:ok, lim_entity_FR} = FinancialReports.create_financial_report(%{entity: lim_entity, supul: hankyung_supul}) 
{:ok, tomi_entity_FR} = FinancialReports.create_financial_report(%{entity: tomi_entity, supul: hanlim_supul}) 

{:ok, korea_supul_FR} = FinancialReports.create_nation_supul_financial_report(%{nation_supul: korea_supul}) 
{:ok, jejudo_supul_FR} = FinancialReports.create_state_supul_financial_report(%{state_supul: jejudo_supul}) 
{:ok, hankyung_supul_FR} = FinancialReports.create_supul_financial_report(%{supul: hankyung_supul}) 
{:ok, hanlim_supul_FR} = FinancialReports.create_supul_financial_report(%{supul: hanlim_supul}) 








#? Income Statement
{:ok, kts_IS} = IncomeStatements.create_tax_income_statement(%{taxation: kts}) 
{:ok, gab_korea_IS} = IncomeStatements.create_public_income_statement(%{nation_supul: korea_supul, entity: gab_korea}) 
{:ok, gopang_korea_IS} = IncomeStatements.create_public_income_statement(%{nation_supul: korea_supul, entity: gopang_korea}) 

{:ok, hong_entity_IS} = IncomeStatements.create_income_statement(%{supul: hankyung_supul, entity: hong_entity}) 
{:ok, sung_entity_IS} = IncomeStatements.create_income_statement(%{supul: hanlim_supul, entity: sung_entity}) 
{:ok, lim_entity_IS} = IncomeStatements.create_income_statement(%{supul: hankyung_supul, entity: lim_entity}) 
{:ok, tomi_entity_IS} = IncomeStatements.create_income_statement(%{supul: hanlim_supul, entity: tomi_entity}) 

{:ok, korea_supul_IS} = IncomeStatements.create_nation_supul_income_statement(%{nation_supul: korea_supul, entity: korea_supul}) 
{:ok, jejudo_supul_IS} = IncomeStatements.create_state_supul_income_statement(%{state_supul: jejudo_supul, entity: jejudo_supul}) 
{:ok, hankyung_supul_IS} = IncomeStatements.create_supul_income_statement(%{supul: hankyung_supul, entity: hankyung_supul}) 
{:ok, hanlim_supul_IS} = IncomeStatements.create_supul_income_statement(%{supul: hankyung_supul, entity: hanlim_supul}) 


#? Balance Sheet
alias Demo.ABC.T1
#? 반자동 국세청
{:ok, kts_BS} = BalanceSheets.create_tax_balance_sheet(%{
  taxation: kts,
  nation_supul: korea_supul,
  cash: Decimal.from_float(0.0),
  gab_balance: Decimal.from_float(0.0),
  })
 
new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: kts.name, 
  output_id: kts.id, 
  amount: Decimal.from_float(1000.0),
  }}

BalanceSheets.add_t1s(kts_BS, new_t1s)  

#? 국가 물류 인프라
{:ok, gopang_korea_BS} = BalanceSheets.create_public_balance_sheet(%{ 
    entity: gopang_korea, 
    nation_supul: korea_supul,
    gab_balance: Decimal.from_float(0.0),
    entity_name: gopang_korea.name,
    cash: Decimal.from_float(0.0),
  })
  
new_t1s = %{t1s: %T1{
  input_name: gab_korea.name, 
  input_id: gab_korea.id, 
  output_name: gopang_korea.name, 
  output_id: gopang_korea.id, 
  amount: Decimal.from_float(1000.0)}}

BalanceSheets.add_t1s(gopang_korea_BS, new_t1s)  

#? 국가 금융 인프라
{:ok, gab_korea_BS} = BalanceSheets.create_public_balance_sheet(%{
      entity: gab_korea,
      nation_supul: korea_supul,
      entity_name: gab_korea.name,
      gab_balance: Decimal.from_float(0.0),
      cash: Decimal.from_float(0.00),
    }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: gab_korea.name, 
  output_id: gab_korea.id, 
  amount: Decimal.from_float(1000.0),
  }}

BalanceSheets.add_t1s(gab_korea_BS, new_t1s)  


#? 홍길동 1인 법인
{:ok, hong_entity_BS} = BalanceSheets.create_balance_sheet(%{
  entity: hong_entity,
  supul: hankyung_supul,
  entity_name: hong_entity.name,
  cash: Decimal.from_float(50_000.0),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: hong_entity.name, 
  output_id: hong_entity.id, 
  amount: Decimal.from_float(100.0),
  }}

BalanceSheets.add_t1s(hong_entity_BS, new_t1s)  

#? 임꺽정 1인 법인
{:ok, lim_entity_BS} = BalanceSheets.create_balance_sheet(%{
  entity: lim_entity,
  entity_name: lim_entity.name,
  supul: hankyung_supul,
  cash: Decimal.from_float(50_000.00),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: lim_entity.name, 
  output_id: lim_entity.id, 
  amount: Decimal.from_float(100.0),
  }}

BalanceSheets.add_t1s(lim_entity_BS, new_t1s)  

#? 성춘향 1인 법인
{:ok, sung_entity_BS} = BalanceSheets.create_balance_sheet(%{
  entity: sung_entity,
  entity_name: sung_entity.name,
  supul: hanlim_supul,
  cash: Decimal.from_float(50_000.00),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: sung_entity.name, 
  output_id: sung_entity.id, 
  amount: Decimal.from_float(100.0),
  }}

BalanceSheets.add_t1s(sung_entity_BS, new_t1s)  

#? 토미 도시락 일반 법인
{:ok, tomi_entity_BS} = BalanceSheets.create_balance_sheet(%{
  entity: tomi_entity,
  entity_name: tomi_entity.name,
  supul: hanlim_supul,
  cash: Decimal.from_float(0.0),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: tomi_entity.name, 
  output_id: tomi_entity.id, 
  amount: Decimal.from_float(100.0),
  }}

tomi_entity_BS = BalanceSheets.add_t1s(tomi_entity_BS, new_t1s)  


# #? Global Supul
# {:ok, global_supul_BS} = BalanceSheets.create_balance_sheet(global_supul, %{
#   entity_name: global_supul.name,
#   cash: Decimal.from_float(0.0),
#   gab_balance: Decimal.from_float(0.0),
#   }) 

# new_t1s =  %{t1s: %T1{
#   input_name: korea.name, 
#   input_id: korea.id, 
#   output_name: global_supul.name, 
#   output_id: global_supul.id, 
#   amount: Decimal.from_float(0.0),
#   }}

# global_supul_BS = BalanceSheets.add_t1s(global_supul_BS, new_t1s)  

    
#? Korea Supul
{:ok, korea_supul_BS} = BalanceSheets.create_nation_supul_balance_sheet(%{
  nation_supul: korea_supul,
  entity_name: korea_supul.name,
  cash: Decimal.from_float(0.0),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: korea_supul.name, 
  output_id: korea_supul.id, 
  amount: Decimal.from_float(1000.0),
  }}

korea_supul_BS = BalanceSheets.add_t1s(korea_supul_BS, new_t1s)  

    
#? Jejudo Supul
{:ok, jejudo_supul_BS} = BalanceSheets.create_state_supul_balance_sheet(%{
  state_supul: jejudo_supul,
  entity_name: jejudo_supul.name,
  cash: Decimal.from_float(0.0),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: jejudo_supul.name, 
  output_id: jejudo_supul.id, 
  amount: Decimal.from_float(1000.0),
  }}

jejudo_supul_BS = BalanceSheets.add_t1s(jejudo_supul_BS, new_t1s)  

#? Hankyung Supul
{:ok, hankyung_supul_BS} = BalanceSheets.create_supul_balance_sheet(%{
  supul: hankyung_supul,
  entity_name: hankyung_supul.name,
  cash: Decimal.from_float(0.0),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: hankyung_supul.name, 
  output_id: hankyung_supul.id, 
  amount: Decimal.from_float(1000.0),
  }}

hankyung_supul_BS = BalanceSheets.add_t1s(hankyung_supul_BS, new_t1s) 

#? Hanlim Supul
{:ok, hanlim_supul_BS} = BalanceSheets.create_supul_balance_sheet(%{
  supul: hanlim_supul,
  entity_name: hanlim_supul.name,
  cash: Decimal.from_float(0.0),
  gab_balance: Decimal.from_float(0.0),
  }) 

new_t1s =  %{t1s: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: hanlim_supul.name, 
  output_id: hanlim_supul.id, 
  amount: Decimal.from_float(1000.0),
  }}

hanlim_supul_BS = BalanceSheets.add_t1s(hanlim_supul_BS, new_t1s)  

    

#? Cash Flow Statement
# gab_korea_CF =
#   IncomeStatement.changeset(%IncomeStatement{}, %{entity_id: gab_korea.id}) |> Repo.insert!()
{:ok, kts_CF} = CFStatements.create_tax_cf_statement(%{nation_supul: korea_supul, taxation: kts}) 
{:ok, gab_korea_CF} = CFStatements.create_public_cf_statement(%{nation_supul: korea_supul, entity: gab_korea}) 
{:ok, gopang_korea_CF} = CFStatements.create_public_cf_statement(%{nation_supul: korea_supul, entity: gopang_korea}) 

{:ok, hong_entity_CF} = CFStatements.create_private_cf_statement(%{supul: hankyung_supul, entity: hong_entity}) 
{:ok, sung_entity_CF} = CFStatements.create_private_cf_statement(%{supul: hanlim_supul, entity: sung_entity}) 
{:ok, tomi_entity_CF} = CFStatements.create_private_cf_statement(%{supul: hanlim_supul, entity: tomi_entity}) 
{:ok, lim_entity_CF} = CFStatements.create_private_cf_statement(%{supul: hankyung_supul, entity: lim_entity}) 

{:ok, korea_supul_CF} = CFStatements.create_nation_supul_cf_statement(%{nation_supul: korea_supul}) 
{:ok, jejudo_supul_CF} = CFStatements.create_state_supul_cf_statement(%{state_supul: jejudo_supul}) 
{:ok, hankyung_supul_CF} = CFStatements.create_supul_cf_statement(%{supul: hankyung_supul}) 
{:ok, hanlim_supul_CF} = CFStatements.create_supul_cf_statement(%{supul: hanlim_supul}) 



#? Equity Statement
# kts_ES =
#   EquityStatement.changeset(%EquityStatement{}, %{entity_id: kts.id}) |> Repo.insert!()
{:ok, kts_ES} = EquityStatements.create_tax_equity_statement(%{taxation: kts}) 
{:ok, gab_korea_ES} = EquityStatements.create_public_equity_statement(%{nation_supul: korea_supul, entity: gab_korea}) 
{:ok, gopang_korea_ES} = EquityStatements.create_public_equity_statement(%{nation_supul: korea_supul, entity: gopang_korea}) 

{:ok, hong_entity_ES} = EquityStatements.create_private_equity_statement(%{supul: hankyung_supul, entity: hong_entity}) 
{:ok, sung_entity_ES} = EquityStatements.create_private_equity_statement(%{supul: hanlim_supul, entity: sung_entity}) 
{:ok, lim_entity_ES} = EquityStatements.create_private_equity_statement(%{supul: hankyung_supul, entity: lim_entity}) 
{:ok, tomi_entity_ES} = EquityStatements.create_private_equity_statement(%{supul: hanlim_supul, entity: tomi_entity}) 

{:ok, korea_supul_ES} = EquityStatements.create_nation_supul_equity_statement(%{nation_supul: korea_supul}) 
{:ok, jejudo_supul_ES} = EquityStatements.create_state_supul_equity_statement(%{state_supul: jejudo_supul}) 
{:ok, hankyung_supul_ES} = EquityStatements.create_supul_equity_statement(%{supul: hankyung_supul}) 
{:ok, hanlim_supul_ES} = EquityStatements.create_supul_equity_statement(%{supul: hanlim_supul}) 






'''
TRANSACTION 1

Transaction between gab_korea_entity and hong_entity.

The price of ABC T1, T2, T3 will be updated every second.
The code below is hard coded. We need write codes for invoice_items with only one item.
'''
# alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}
# alias Demo.Entities.Product
alias Demo.Entities


#? From now on, let's write invoice for trade between mr_hong and gab_korea.
#? First, let "krw" a product of hong_entity
{:ok, krw} = Entities.create_product(hong_entity, %{
  name: "KRW", 
  seller_id: hong_entity.id,
  seller_name: hong_entity.name,
  seller_supul_name: "hanlim_supul",
  seller_supul_id: hanlim_supul.id,
  price: Decimal.from_float(0.0012),
  }) 
  






alias Demo.Entities
alias Demo.Entities.BizCategory

for category <- [%{name: "한식 일반 음식점업", standard: "한국표준산업분류표", code: "56111"}, %{name: "김밥 및 기타 간이 음식점업", standard: "한국표준산업분류표", code: "56194"}] do
  Entities.create_biz_category!(category)
end


alias Demo.Entities.GPCCode
# 분식 = GPCCode.changeset(%GPCCode{name: "분식", code: "345445", standard: "GTIN"}) |> Repo.insert!
# 한식 = GPCCode.changeset(%GPCCode{name: "한식", code: "345446", standard: "GTIN"}) |> Repo.insert!
{:ok, 분식} = Entities.create_GPCCode(%{name: "분식", code: "345445", standard: "GTIN"}) 
{:ok, 한식} = Entities.create_GPCCode(%{name: "한식", code: "345446", standard: "GTIN"}) 


alias Demo.Entities.Product
#? 토미 김밥의 상품
# 김밥 = Product.changeset(%Product{name: "김밥", gpc_code_id: 분식.id, price: 1.0}) |> Repo.insert!
{:ok, 김밥} = Entities.create_product(tomi_entity, %{
  name: "김밥", 
  gpc_code_id: 분식.id, 
  price: 1.0
  }) 
{:ok, 떡볶이} =  Entities.create_product(tomi_entity, %{name: "떡볶이", gpc_code_id: 분식.id, price: 1.5}) 
{:ok, 우동} = Entities.create_product(tomi_entity, %{name: "우동", gpc_code_id: 분식.id, price: 1.5}) 


#? 임꺽정 산채의 상품
{:ok, 한정식} = Entities.create_product(lim_entity, %{name: "한정식", gpc_code_id: 한식.id, price: 5.0})
{:ok, 육개장} = Entities.create_product(lim_entity, %{name: "육개장", gpc_code_id: 한식.id, price: 3.5})
{:ok, 갈비탕} = Entities.create_product(lim_entity, %{name: "갈비탕", gpc_code_id: 한식.id, price: 3.5})

 
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

