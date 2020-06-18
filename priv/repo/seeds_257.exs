import Ecto.Query
import Ecto.Changeset
alias Demo.Repo

# ? init nations
alias Demo.Nations.Nation

# ? init supuls. For example, Korea will have about 5,000 supuls.
alias Demo.Supuls.GlobalSupul
alias Demo.Supuls.NationSupul
alias Demo.Supuls.StateSupul
alias Demo.Supuls.Supul

global_supul =
  GlobalSupul.changeset(%GlobalSupul{}, %{name: "Global Supul", supul_code: 0x00000000}) \
  |> Repo.insert!()

korea_supul =
  NationSupul.changeset(%NationSupul{}, %{name: "Korea Supul", supul_code: 0x52000000}) \
  |> Repo.insert!()

jejudo_supul =
  StateSupul.changeset(%StateSupul{}, %{name: "Jejudo Supul", supul_code: 0x01434500}) \
  |> Repo.insert!()

hankyung_supul =
  Supul.changeset(%Supul{}, %{name: "Hankyung Supul", supul_code: 0x01434500}) \
  |> Repo.insert!()

hanlim_supul =
  Supul.changeset(%Supul{}, %{name: "Hanlim Supul", supul_code: 0x35434500}) \
  |> Repo.insert!()



  '''

  CRYPTO
  Both users and entities should have private and public keys for future transactions.
  '''

  # ? openssl genrsa -out jejudo_private_key.pem 2048
  # ? openssl rsa -in jejudo_private_key.pem -pubout > jejudo_public_key.pem
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
     
#? SIGNATURES
# import Poison

#? global supul authorizes nation supuls and so on. 
import Poison

#? GLOBAL SUPUL
#? global supul authorizes itself with its own private key.
msg_serialized = Poison.encode!(global_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, global_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
global_supul = change(global_supul) |> Ecto.Changeset.put_change(:global_signature, signature) |> Repo.update!

#? NATION SUPULS
#? global supul authorizes nation supuls with its private key.
msg_serialized = Poison.encode!(korea_supul.name)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, global_signature} = ExPublicKey.sign(ts_msg_serialized, global_rsa_priv_key)
{:ok, korea_signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)

# combine payload
payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64(global_signature)}|#{Base.url_encode64(korea_signature)}"
payload_hash = Pbkdf2.hash_pwd_salt(payload)

korea_supul = change(korea_supul) |> Ecto.Changeset.put_change(:payload, payload) |> Repo.update!
korea_supul = change(korea_supul) |> Ecto.Changeset.put_change(:payload_hash, payload_hash) |> Repo.update!

#? STATE SUPULS
#? global supul and nation supul authorizes state supuls with their private keys.
msg_serialized = Poison.encode!(jejudo_supul.name)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, global_signature} = ExPublicKey.sign(ts_msg_serialized, global_rsa_priv_key)
{:ok, korea_signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
{:ok, jejudo_signature} = ExPublicKey.sign(ts_msg_serialized, jejudo_rsa_priv_key)

# combine payload
payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64(global_signature)}|#{Base.url_encode64(korea_signature)}|#{Base.url_encode64(jejudo_signature)}"
payload_hash = Pbkdf2.hash_pwd_salt(payload)

jejudo_supul = change(jejudo_supul) |> Ecto.Changeset.put_change(:payload, payload) |> Repo.update!
jejudo_supul = change(jejudo_supul) |> Ecto.Changeset.put_change(:payload_hash, payload_hash) |> Repo.update!

#? SUPULS
#? global supul, nation supul, and state supul authorizes supuls with their private keys.
#? Hankyung
msg_serialized = Poison.encode!(hankyung_supul.name)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, global_signature} = ExPublicKey.sign(ts_msg_serialized, global_rsa_priv_key)
{:ok, korea_signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
{:ok, jejudo_signature} = ExPublicKey.sign(ts_msg_serialized, jejudo_rsa_priv_key)
{:ok, hankyung_signature} = ExPublicKey.sign(ts_msg_serialized, hankyung_rsa_priv_key)

# combine payload
payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64(global_signature)}|#{Base.url_encode64(korea_signature)}|#{Base.url_encode64(jejudo_signature)}|#{Base.url_encode64(hankyung_signature)}"
payload_hash = Pbkdf2.hash_pwd_salt(payload)

hankyung_supul = change(hankyung_supul) |> Ecto.Changeset.put_change(:payload, payload) |> Repo.update!
hankyung_supul = change(hankyung_supul) |> Ecto.Changeset.put_change(:payload_hash, payload_hash) |> Repo.update!

#? Hanlim
msg_serialized = Poison.encode!(hankyung_supul.name)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, global_signature} = ExPublicKey.sign(ts_msg_serialized, global_rsa_priv_key)
{:ok, korea_signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
{:ok, jejudo_signature} = ExPublicKey.sign(ts_msg_serialized, jejudo_rsa_priv_key)
{:ok, hankyung_signature} = ExPublicKey.sign(ts_msg_serialized, hankyung_rsa_priv_key)

# combine payload
payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64(global_signature)}|#{Base.url_encode64(korea_signature)}|#{Base.url_encode64(jejudo_signature)}|#{Base.url_encode64(hankyung_signature)}"
payload_hash = Pbkdf2.hash_pwd_salt(payload)

hankyung_supul = change(hankyung_supul) |> Ecto.Changeset.put_change(:payload, payload) |> Repo.update!
hankyung_supul = change(hankyung_supul) |> Ecto.Changeset.put_change(:payload_hash, payload_hash) |> Repo.update!


'''

CONSTITUTIONS AND NATIONS

'''
alias Demo.Votes.Constitution

korea_constitution = Constitution.changeset(%Constitution{}, %{nationality: "South Korea", content: "대한민국은 민주공화국이다."}) |> Repo.insert!
msg_serialized = Poison.encode!(korea_constitution)
content_hash = Pbkdf2.hash_pwd_salt(msg_serialized)

korea_constitution = change(korea_constitution) |> Ecto.Changeset.put_change(:content_hash, content_hash) |> Repo.update!


# ? openssl genrsa -out constitution_private_key.pem 2048
# ? openssl rsa -in constitution_private_key.pem -pubout > constitution_public_key.pem
constitution_rsa_priv_key = ExPublicKey.load!("./keys/constitution_private_key.pem")
constitution_rsa_pub_key = ExPublicKey.load!("./keys/constitution_public_key.pem")
    
#? KOREA

alias Demo.Nations.Nation
korea =
Nation.changeset(%Nation{}, %{
  name: "South_Korea", 
  }) |> Repo.insert!()



#? Make a nation with the signature of her constitution.
msg_serialized = Poison.encode!(korea)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, constitution_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
korea = change(korea) |> Ecto.Changeset.put_change(:constitution_signature, signature) |> Repo.update!






# ? init users
alias Demo.Accounts.User

# {ok, mr_hong} = User.changeset(%User{}, %{name: "Hong Gildong"}) |> Repo.insert
mr_hong =
  User.changeset(%User{}, %{
    name: "Hong_Gildong", 
    nationality: "South Korea", 
    username: "mr_hong", 
    email: "hong_gil_dong@82345.kr",
    type: "Human",
    birth_date: ~N[1990-05-05 06:14:09],
    nation_id: korea.id,
    constitution_id: korea_constitution.id,
    supul_id: hankyung_supul.id
    }) \
  |> Repo.insert!()

msg_serialized = Poison.encode!(mr_hong)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
mr_hong = change(mr_hong) |> Ecto.Changeset.put_change(:ssn, signature) |> Repo.update!
  
   
ms_sung =
  User.changeset(%User{}, %{
    nationality: "South Korea", 
    name: "Sung_Chunhyang", 
    username: "ms_sung", 
    email: "sung_chun_hyang@82345.kr",
    type: "Human",
    birth_date: ~N[2000-09-09 16:14:09],
    nation_id: korea.id,
    constitution_id: korea_constitution.id,
    supul_id: hanlim_supul.id
    }) \
  |> Repo.insert!()

msg_serialized = Poison.encode!(ms_sung)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
ms_sung = change(ms_sung) |> Ecto.Changeset.put_change(:ssn, signature) |> Repo.update!

  
mr_lim =
  User.changeset(%User{}, %{
    nationality: "South Korea", 
    name: "Lim_Geukjung", 
    username: "mr_lim", 
    email: "limgeukjung@88889.kr",
    type: "Human",
    ssn: "5410051898822kr",
    birth_date: ~N[1970-11-11 09:14:09],
    nation_id: korea.id,
    constitution_id: korea_constitution.id, 
    supul_id: hankyung_supul.id
    }) \
  |> Repo.insert!()

msg_serialized = Poison.encode!(mr_lim)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
mr_lim = change(mr_lim) |> Ecto.Changeset.put_change(:ssn, signature) |> Repo.update!

  


'''

SPECIAL USER == COREA
corea will act as the representative of the nation Korea in 
any transaction in which a governmental organization participates in.

'''
corea =
  User.changeset(%User{}, %{
    nationality: "South Korea", 
    name: "COREA", 
    username: "COREA", 
    email: "corea@00000.kr",
    type: "Nation",
    nation_id: korea.id,
    constitution_id: korea_constitution.id, 
    nation_supul_id: korea_supul.id
    }) \
  |> Repo.insert!()

msg_serialized = Poison.encode!(corea)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
corea = change(corea) |> Ecto.Changeset.put_change(:ssn, signature) |> Repo.update!

#? Set passwords of all users
for u <- Repo.all(User) do
  Repo.update!(User.registration_changeset(u, %{password: "temppass"}))
end


'''

ENTITIES

'''

# ? init entities
alias Demo.Business.Entity

#? 국세청 Korea's Entity == a governmental organization  
kts =
  Entity.changeset(%Entity{}, %{
    nationality: "South Korea", 
    name: "Korea Tax Service", 
    email: "kts@000001.un",
    user_id: corea.id,
    nation_id: korea.id,
    nation_supul_id: korea_supul.id
    }) \
  |> Repo.insert!()

msg_serialized = Poison.encode!(kts)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
kts = change(kts) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!


#? 국가 금융 인프라 Korea's Entity == a governmental organization  
gab_korea =
  Entity.changeset(%Entity{}, %{
    nationality: "South Korea", 
    name: "GAB_Korea", 
    email: "gab@000221.un",
    user_id: corea.id,
    nation_id: korea.id,
    nation_supul_id: korea_supul.id,
    }) \
  |> Repo.insert!()

msg_serialized = Poison.encode!(gab_korea)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
gab_korea = change(gab_korea) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!

#? 국가 교통물류 인프라 Korea's Entity == a governmental organization  
gopang_korea =
  Entity.changeset(%Entity{}, %{
    nationality: "South Korea", 
    name: "gopang_Korea", 
    email: "gopang@000221.un",
    user_id: corea.id,
    nation_id: korea.id,
    nation_supul_id: korea_supul.id,
    }) \
  |> Repo.insert!()

msg_serialized = Poison.encode!(gopang_korea)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
gopang_korea = change(gopang_korea) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!
  

#? 시민 홍길동의 비즈니스 :: Hong's Entity
hong_entity =
  Entity.changeset(%Entity{}, %{
    nationality: "South Korea", 
    name: "Hong Gildong Entity", 
    email: "hong_gil_dong@8245.kr", 
    entity_address: "제주시 한경면 20-1 해거름전망대",
    user_id: mr_hong.id,
    nation_id: korea.id,
    supul_id: hankyung_supul.id,
    }) \
  |> Repo.insert!()

msg_serialized = Poison.encode!(hong_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
hong_entity = change(hong_entity) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!
 
  
#? 시민 성춘향의 비즈니스 :: Sung's Entity
sung_entity =
  Entity.changeset(%Entity{}, %{
    name: "Sung Chunhyang Entity", 
    email: "sung_gil_dong@8245.kr", 
    entity_address: "제주시 한경면 20-1 해거름전망대",
    user_id: ms_sung.id,
    nation_id: korea.id,
    supul_id: hanlim_supul.id,
    }) \
  |> Repo.insert!()

msg_serialized = Poison.encode!(sung_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
sung_entity = change(sung_entity) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!
     

#? 시민 임꺽정의 비즈니스 :: Lim's Entity
lim_entity =
  Entity.changeset(%Entity{}, %{
    name: "Lim Geukjung Entity", 
    email: "limgeukjung@88889@8245.kr", 
    entity_address: "서귀포시 안덕면 77-1",
    user_id: mr_lim.id,
    nation_id: korea.id,
    supul_id: hankyung_supul.id,
    }) \
  |> Repo.insert!()

msg_serialized = Poison.encode!(lim_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
lim_entity = change(lim_entity) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!
    

#? 시민 성춘향의 또 하나의 비즈니스 
tomi_entity =
  Entity.changeset(%Entity{}, %{
    name: "Tomi Lunch Box", 
    email: "tomi@3532.kr", 
    entity_address: "제주시 한림읍 11-1",
    user_id: ms_sung.id,
    nation_id: korea.id,
    supul_id: hanlim_supul.id,
    }) \
  |> Repo.insert!()

msg_serialized = Poison.encode!(tomi_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
tomi_entity = change(tomi_entity) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!
   



'''

CRYPTO
Both users and entities should have private and public keys for future transactions.
'''

# ? openssl genrsa -out kts_private_key.pem 2048
# ? openssl rsa -in kts_private_key.pem -pubout > kts_public_key.pem

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
mr_hong = User.changeset_update_entities(mr_hong, [hong_entity])
hong_entity = Entity.changeset_update_users(hong_entity, [mr_hong])

#? 임꺽정과 그의 비즈니스
User.changeset_update_entities(mr_lim, [lim_entity])
Entity.changeset_update_users(lim_entity, [mr_lim])

#? 성춘향과 그녀의 비즈니스들
User.changeset_update_entities(ms_sung, [tomi_entity,sung_entity])
Entity.changeset_update_users(tomi_entity, [ms_sung])
Entity.changeset_update_users(sung_entity, [ms_sung])

#? Corea와 정부 또는 공공 기관들
User.changeset_update_entities(corea, [kts, gab_korea, gopang_korea])
Entity.changeset_update_users(kts, [corea])
Entity.changeset_update_users(gab_korea, [corea])
Entity.changeset_update_users(gopang_korea, [corea])



'''   

PUT_ASSOC 
entity and supul

'''

# ? make a gopang branch for Hangkyung Supul. Remember every supul has one, only one Gopang branch.
gopang = Ecto.build_assoc(hankyung_supul, :gopang, gopang)



'''   

PUT_ASSOC 
entity and supul

'''
# ? prepare financial statements for entities.
alias Demo.Reports.FinancialReport
alias Demo.Reports.BalanceSheet
alias Demo.Reports.GabBalanceSheet
alias Demo.Reports.GopangBalanceSheet

gopang_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: gopang.id}) |> Repo.insert!()

hong_entity_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: hong_entity.id}) |> Repo.insert!()



lim_entity_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: lim_entity.id}) |> Repo.insert!()

tomi_entity_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: tomi_entity.id}) |> Repo.insert!()




gopang_BS =
  Ecto.build_assoc(gopang_FR, :gov_balance_sheet, %GopangBalanceSheet{
    monetary_unit: "KRW",
    t1s: [%{input: korea.id, output: gopang.id, amount: Decimal.from_float(10_000_000.00)}],
    cashes: [%{KRW: Decimal.from_float(10_000_000_000.00)}]
  }) \
  |> Repo.insert!()

hong_entity_BS =
  Ecto.build_assoc(hong_entity, :balance_sheet, %BalanceSheet{
    cash: Decimal.from_float(50_000_000.00),
    t1s: [%{
      input: korea.id, 
      output: gopang.id, 
      amount: Decimal.from_float(10_000.00)}]}) \
  |> Repo.insert!()

lim_entity_BS =
  Ecto.build_assoc(lim_entity, :balance_sheet, %BalanceSheet{
    cash: Decimal.from_float(50_000_000.00),
    t1s: [%{
      input: korea.id, 
      output: gopang.id, 
      amount: Decimal.from_float(10_000.00)}]}) \
  |> Repo.insert!()

tomi_entity_BS =
  Ecto.build_assoc(tomi_entity, :balance_sheet, %BalanceSheet{
    fixed_assets: [%{building: 1.0}],
    t1s: [%{
      input: korea.id, 
      output: gopang.id, 
      amount: Decimal.from_float(10_000.00)}]
    }) \
  |> Repo.insert!()



alias Demo.Reports.IncomeStatement

hong_entity_IS =
  Ecto.build_assoc(hong_entity, :income_statement, %IncomeStatement{
    revenue: Decimal.from_float(20_000.00),
    cost_of_goods_sold: Decimal.from_float(10_000.00),
  }) \
  |> Repo.insert!()



alias Demo.Reports.CFStatement

hong_entity_CFS =
  Ecto.build_assoc(hong_entity, :cf_statement, %CFStatement{
    debt_issuance: Decimal.from_float(20_000.00),
    equity_issuance: Decimal.from_float(100_000.00),
  }) \
  |> Repo.insert!()

'''

CERTIFICATE GRANT
보건복지부는 성춘향에게 전문의 자격증을 발급

'''
alias Demo.Documents.Document

 document = Document.changeset(
    %Document{
        title: "진단의학 전문의 자격증",
        presented_to: sung_entity.id,
        presented_by: [mohw.id],
        summary: "위와 같이 자격을....",
        attached_docs_list: ["졸업증명서.id", "의사_국가시험_합격증명서.id", "전학년_성적증명서.id"],
        attached_docs_hashes: ["졸업증명서_hash", "의사_국가시험_합격증명서_hash", "전학년_성적증명서_hash"],
        hash_of_attached_docs_hashes: "sha256(attached_docs_hashes)",
    }) |> Repo.insert!

alias Demo.Certificates.Certificate
certificate = Certificate.changeset(%Certificate{name: "Diagnostic medicine specialist", document: document.id, issued_to: sung_entity.id, issued_date: Timex.to_date({2015, 6, 24})}) |> Repo.insert!

 
'''

License GRANT
서울시 도봉구는 토미 클리닉을 관내 의료기관으로 등기

'''
 document = Document.changeset(
    %Document{
        title: "의료기관 등기",
        presented_to: tomi_clinic.id,
        presented_by: [seoul.id],
        summary: "위와 같이 ....",
        attached_docs_list: [],
        attached_docs_hashes: [],
        hash_of_attached_docs_hashes: "sha256(attached_docs_hashes)",
    }) |> Repo.insert!

alias Demo.Licenses.License
license = License.changeset(%License{name: "Tomi Clinic", document: document.id, issued_to: sung_entity.id, issued_date: Timex.to_date({2015, 6, 24})}) |> Repo.insert!



'''

TRANSACTION
성춘향은 보건복지부에 전문의 자격증 발급 수수료를 지불

'''
alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}
alias Demo.Tickets.Ticket

# ? write invoice for trade between mr_sung and mohw.
item = Item.changeset(%Item{}, %{product_uuid: certificate.id, price: Decimal.from_float(100.0),
document: document.id}) |> Repo.insert!()

# ? issue an ticket
ticket = Ticket.changeset(%Ticket{}, %{item_id: item.id}) |> Repo.insert!()


invoice_items = [
  %{item_id: item.id, quantity: 1.0, item_name: "Diagnostic Specialist Certificate"},
  %{item_id: item.id, quantity: 0.0}
]

params = %{
  "buyer" => %{"main" => sung_entity.id, "participants" => sung_entity.id},
  "seller" => %{"main" => mohw.id, "participants" => mohw.id},
  "invoice_items" => invoice_items
}

{:ok, invoice} = Invoice.create(params)

# invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!

# ? hash_of_invoice = sung_public_sha256 = :crypto.hash(:sha256, invoice)




'''

Ticket
전문의 자격증 발급 사항을 보건복지부가 소속된 Korea Supul에 기록

'''
# ? calculate route, then embed it on the ticket. 


# ? Write Transaction p
alias Demo.Transactions.Transaction
txn =
  Transaction.changeset(%Transaction{
    abc_input: sung_entity.id,
    abc_output: mohw.id,
    abc_amount: invoice.total,
    items: [certificate.id],
  }) \
  |> Repo.insert!()

# ? Association between Transaction and Invoice
invoice = Ecto.build_assoc(txn, :invoice, invoice)
ticket = Ecto.build_assoc(txn, :ticket, ticket)


preloaded_ticket = Repo.preload(ticket, [:transaction])

    

'''

SIGNATURE
First, both buyer and seller sign the ticket.

'''
import Poison

# serialize the JSON
msg_serialized = Poison.encode!(preloaded_ticket)

# generate time-stamp
ts = DateTime.utc_now() |> DateTime.to_unix()

# add a time-stamp
ts_msg_serialized = "#{ts}|#{msg_serialized}"

# generate a secure hash using SHA256 and sign the message with the private key
{:ok, buyer_signature} = ExPublicKey.sign(ts_msg_serialized, sung_rsa_priv_key)
{:ok, seller_signature} = ExPublicKey.sign(ts_msg_serialized, mohw_rsa_priv_key)

# combine payload
payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64(buyer_signature)}|#{Base.url_encode64(seller_signature)}"

#? send the payload to the NEAREST common supul of both buyer and seller. 


'''

SUPUL
Second, the supul_mulet verifies and unserialize the payload from mr_sung. 

'''

alias Demo.Mulets.Mulet
korea_mulet = Ecto.build_assoc(korea_supul, :mulet, %{current_hash: korea_supul.id})

#? pretend transmit the message...
#? pretend receive the message...

#? break up the payload
parts = String.split(payload, "|")

# ? reject the payload if the timestamp is newer than the arriving time to mulet. 
recv_ts = Enum.fetch!(parts, 0)

#? pretend ensure the time-stamp is not too old (or from the future)...
#? verify the signature
recv_msg_serialized = Enum.fetch!(parts, 1)
{:ok, recv_sig_buyer} = Enum.fetch!(parts, 2) |> Base.url_decode64()
{:ok, recv_sig_seller} = Enum.fetch!(parts, 3) |> Base.url_decode64()

{:ok, sig_valid_buyer} =
  ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig_buyer, sung_rsa_pub_key)

{:ok, sig_valid_seller} =
  ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig_seller, mohw_rsa_pub_key)

# assert(sig_valid)

#? Archieve Tickets
alias Demo.Mulets.TicketStorage
alias Demo.Tickets.Payload
payload_archive = Payload.changeset(%Payload{payload: payload}) |> Repo.insert!
payload_archive = Ecto.build_assoc(korea_supul, :payloads, payload_archive)

payload_storage = TicketStorage.changeset(%TicketStorage{}, %{new_payload: payload_archive})



#? recv_msg_unserialized = Poison.Parser.parse!(recv_msg_serialized, %{})
# assert(msg == recv_msg_unserialized)




'''

Adjust balance_sheet of both.
성춘향과 보건복지부의 BS를 업데이트

'''
alias Demo.ABC.T1

# ? mohw
new_t1s =
  Enum.map(mohw_BS.t1s, fn elem ->
    Map.update!(elem, :amount, fn curr_value -> Decimal.add(curr_value, ticket.mohw_fee) end)
  end)

mohw_BS = change(mohw_BS) |> Ecto.Changeset.put_change(:t1s, new_t1s) |> Repo.update!()


# ? mr_sung
residual_amount = Decimal.sub(Enum.at(sung_entity_BS.t1s, 0).amount, txn.abc_amount)
new_t1s = [%T1{input: sung_entity.id, output: sung_entity.id, amount: residual_amount}]
sung_entity_BS = change(sung_entity_BS) |> Ecto.Changeset.put_embed(:t1s, new_t1s) |> Repo.update!

# ? mohw
new_t1s = [%T1{input: sung_entity.id, output: mohw_entity.id, amount: txn.abc_amount} | mohw_entity_BS.t1s]
mohw_entity_BS = change(mohw_entity_BS) |> Ecto.Changeset.put_embed(:t1s, new_t1s) |> Repo.update!


'''

Third, the mulet of supul, state_supul, korea_supul and global_supul openhashes the unserialized message. 

'''

#? Supul Mulet 
#? pretend transmit the message...
#? pretend receive the message...
korea_mulet = Ecto.build_assoc(korea_supul, :mulet, %{current_hash: korea_supul.id}) 

incoming_hash = :crypto.hash(:sha256, payload) \
  |> Base.encode16() \
  |> String.downcase()
korea_mulet = Mulet.changeset(korea_mulet, %{incoming_hash: incoming_hash})


#? send every 100th payload to the nation_supul of sate_supul.
korea_mulet = Ecto.build_assoc(korea_supul, :mulet, %{current_hash: korea_supul.id}) 
korea_mulet = Mulet.changeset(korea_mulet, %{incoming_hash: incoming_hash})

#? send every 10000th payload to the global_supul of sate_supul.
global_mulet = Ecto.build_assoc(global_supul, :mulet, %{current_hash: global_supul.id}) 
global_mulet = Mulet.changeset(global_mulet, %{incoming_hash: incoming_hash})



