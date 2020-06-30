import Ecto.Query
import Ecto.Changeset
alias Demo.Repo

#? Init supuls
alias Demo.GlobalSupuls
alias Demo.NationSupuls
alias Demo.StateSupuls
alias Demo.Supuls

{ok, global_supul} = GlobalSupuls.create_global_supul(%{type: "GlobalSupul", name: "Global Supul", supul_code: 0x00000000})
{ok, korea_supul} = NationSupuls.create_nation_supul(%{type: "NationSupul", name: "Korea Supul", supul_code: 0x52000000})
{ok, jejudo_supul} = StateSupuls.create_state_supul(%{type: "StateSupul", name: "Jejudo Supul", supul_code: 0x01434500})
{ok, hankyung_supul} = Supuls.create_supul(%{type: "UnitSupul", name: "Hankyung Supul", supul_code: 0x01434500})
{ok, hanlim_supul} = Supuls.create_supul(%{type: "UnitSupul", name: "Hanlim Supul", supul_code: 0x35434500})


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
     
'''

SIGNATURES & AUTHORIZATION CHAIN
All users, entities, nations and supuls etc. 
should be authorized by something 
which also has been authorized by something...and so on.
Ultimately, the global supul is the origin of authorization chains. 

'''
#? global supul authorizes nation supuls and so on. 
import Poison

#? GLOBAL SUPUL
#? global supul authorizes itself with its own private key.
msg_serialized = Poison.encode!(global_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, global_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

# global_supul = change(global_supul) |> Ecto.Changeset.put_change(:global_signature, signature) |> Repo.update!
{:ok, global_supul} = GlobalSupuls.update_global_supul(global_supul, %{type: "GlobalSupul", global_signature: signature}) 

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

# korea_supul = change(korea_supul) |> Ecto.Changeset.put_change(:payload, payload) |> Repo.update!
# korea_supul = change(korea_supul) |> Ecto.Changeset.put_change(:payload_hash, payload_hash) |> Repo.update!
{:ok, korea_supul} = NationSupuls.update_nation_supul(korea_supul, %{payload: payload}) 
{:ok, korea_supul} = NationSupuls.update_nation_supul(korea_supul, %{payload_hash: payload_hash}) 

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

# jejudo_supul = change(jejudo_supul) |> Ecto.Changeset.put_change(:payload, payload) |> Repo.update!
# jejudo_supul = change(jejudo_supul) |> Ecto.Changeset.put_change(:payload_hash, payload_hash) |> Repo.update!
{:ok, jejudo_supul} = StateSupuls.update_state_supul(jejudo_supul, %{payload: payload}) 
{:ok, jejudo_supul} = StateSupuls.update_state_supul(jejudo_supul, %{payload_hash: payload_hash}) 

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

# hankyung_supul = change(hankyung_supul) |> Ecto.Changeset.put_change(:payload, payload) |> Repo.update!
# hankyung_supul = change(hankyung_supul) |> Ecto.Changeset.put_change(:payload_hash, payload_hash) |> Repo.update!
{:ok, hankyung_supul} = Supuls.update_supul(hankyung_supul, %{payload: payload}) 
{:ok, hankyung_supul} = Supuls.update_supul(hankyung_supul, %{payload_hash: payload_hash}) 

#? Hanlim
msg_serialized = Poison.encode!(hankyung_supul.name)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, global_signature} = ExPublicKey.sign(ts_msg_serialized, global_rsa_priv_key)
{:ok, korea_signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
{:ok, jejudo_signature} = ExPublicKey.sign(ts_msg_serialized, jejudo_rsa_priv_key)
{:ok, hanlim_signature} = ExPublicKey.sign(ts_msg_serialized, hanlim_rsa_priv_key)

# combine payload
payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64(global_signature)}|#{Base.url_encode64(korea_signature)}|#{Base.url_encode64(jejudo_signature)}|#{Base.url_encode64(hanlim_signature)}"
payload_hash = Pbkdf2.hash_pwd_salt(payload)

# hanlim_supul = change(hanlim_supul) |> Ecto.Changeset.put_change(:payload, payload) |> Repo.update!
# hanlim_supul = change(hanlim_supul) |> Ecto.Changeset.put_change(:payload_hash, payload_hash) |> Repo.update!
{:ok, hanlim_supul} = Supuls.update_supul(hanlim_supul, %{payload: payload}) 
{:ok, hanlim_supul} = Supuls.update_supul(hanlim_supul, %{payload_hash: payload_hash}) 


'''

CONSTITUTIONS AND NATIONS

'''
alias Demo.Constitutions
alias Demo.Votes.Constitution

# korea_constitution = Constitution.changeset(%Constitution{}, %{nationality: "South Korea", content: "대한민국은 민주공화국이다."}) |> Repo.insert!
{:ok, korea_constitution} = Constitutions.create_constitution(%{nationality: "South Korea", content: "대한민국은 민주공화국이다."}) 




msg_serialized = Poison.encode!(korea_constitution)
content_hash = Pbkdf2.hash_pwd_salt(msg_serialized)

# korea_constitution = change(korea_constitution) |> Ecto.Changeset.put_change(:content_hash, content_hash) |> Repo.update!
{:ok, korea_constitution} = Constitutions.update_constitution(korea_constitution, %{content_hash: content_hash}) 


# ? openssl genrsa -out constitution_private_key.pem 2048
# ? openssl rsa -in constitution_private_key.pem -pubout > constitution_public_key.pem
constitution_rsa_priv_key = ExPublicKey.load!("./keys/constitution_private_key.pem")
constitution_rsa_pub_key = ExPublicKey.load!("./keys/constitution_public_key.pem")
    
#? KOREA
#? born but not authorized nation. 
alias Demo.Nations
alias Demo.Nations.Nation
{:ok, korea} = Nations.create_nation(%{name: "South_Korea"}) 


#? Make a nation with the signature of her constitution.
msg_serialized = Poison.encode!(korea)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, constitution_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

# korea = change(korea) |> Ecto.Changeset.put_change(:constitution_signature, signature) |> Repo.update!
{:ok, korea} = Nations.update_nation(korea, %{constitution_signature: signature}) 





# ? init users
alias Demo.Accounts
alias Demo.Accounts.User

# {ok, mr_hong} = User.changeset(%User{}, %{name: "Hong Gildong"}) |> Repo.insert
#? A human being with nationality he or she claims.
{:ok, mr_hong} = Accounts.create_user(%{
    name: "Hong_Gildong", 
    nationality: "South Korea", 
    username: "mr_hong", 
    password: "temppass",
    email: "hong_gil_dong@8245.kr",
    type: "Human",
    birth_date: ~N[1990-05-05 06:14:09],
    nation_id: korea.id,
    constitution_id: korea_constitution.id,
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
    name: "Sung_Chunhyang", 
    username: "ms_sung", 
    email: "sung_chunhyang@82345.kr",
    password: "temppass",
    type: "Human",
    birth_date: ~N[2000-09-09 16:14:09],
    nation_id: korea.id,
    constitution_id: korea_constitution.id,
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
    name: "Lim_Geukjung", 
    username: "mr_lim", 
    password: "temppass",
    email: "limgeukjung@8889.kr",
    type: "Human",
    ssn: "5410051898822kr",
    birth_date: ~N[1970-11-11 09:14:09],
    nation_id: korea.id,
    constitution_id: korea_constitution.id, 
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

SPECIAL USER == COREA
corea will act as the representative of the nation Korea in 
any transaction in which a governmental organization participates in.

'''
#? The representative citizen of a nation.
{:ok, corea} = Accounts.create_user(%{
    nationality: "South Korea", 
    name: "COREA", 
    username: "COREA", 
    password: "temppass",
    email: "corea@kr",
    type: "Nation",
    nation_id: korea.id,
    constitution_id: korea_constitution.id, 
    nation_supul_id: korea_supul.id,
    username: "corea"
    }) 


msg_serialized = Poison.encode!(corea)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# corea = change(corea) |> Ecto.Changeset.put_change(:ssn, signature) |> Repo.update!
{:ok, corea} = Accounts.update_user(corea, %{ssn: signature}) 



'''

ENTITIES

'''

# ? init entities
alias Demo.Business
alias Demo.Business.Entity

#? 국세청 corea's Entity == a governmental organization  
{:ok, kts} = Business.create_entity(corea, %{
    nationality: "South Korea", 
    name: "Korea Tax Service", 
    project: "반자동 국세청", 
    pasword: "temppass",
    supul_name: "한국",
    email: "kts@kr",
    user_id: corea.id,
    nation_id: korea.id,
    nation_supul_id: korea_supul.id,
    gab_balance: Decimal.from_float(10_000.0),
    }) 

#? Korea authorizes its governmental organizations.  
msg_serialized = Poison.encode!(kts)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# kts = change(kts) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!
{:ok, kts} = Business.update_entity(kts, %{registered_no: signature}) 


#? 국가 금융 인프라 Korea's Entity == a governmental organization  
{:ok, gab_korea} = Business.create_entity(corea, %{
    nationality: "South Korea", 
    name: "GAB_Korea", 
    project: "국가 금융 인프라", 
    supul_name: "한국",
    pasword: "temppass",
    email: "gab_korea@kr",
    user_id: corea.id,
    nation_id: korea.id,
    nation_supul_id: korea_supul.id,
    gab_balance: Decimal.from_float(1_000_000.0),
    })

msg_serialized = Poison.encode!(gab_korea)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# gab_korea = change(gab_korea) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!
{:ok, gab_korea} = Business.update_entity(gab_korea, %{registered_no: signature}) 

#? 국가 교통물류 인프라 Korea's Entity == a governmental organization  
{:ok, gopang_korea} = Business.create_entity(corea, %{
    nationality: "South Korea", 
    name: "Gopang_Korea", 
    project: "국가 물류 인프라",
    supul_name: "한국",
    pasword: "temppass",
    email: "gopang_korea@kr",
    user_id: corea.id,
    nation_id: korea.id,
    nation_supul_id: korea_supul.id,
    gab_balance: Decimal.from_float(10_000.0),
    }) 

msg_serialized = Poison.encode!(gopang_korea)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# gopang_korea = change(gopang_korea) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!
{:ok, gopang_korea} = Business.update_entity(gopang_korea, %{registered_no: signature}) 


#? 시민 홍길동의 비즈니스 :: Hong's Entity
{:ok, hong_entity} = Business.create_entity(corea, %{
    nationality: "South Korea", 
    name: "Hong Gildong Entity", 
    supul_name: "한경면",
    pasword: "temppass",
    email: "hong@8245.kr", 
    entity_address: "제주시 한경면 20-1 해거름전망대",
    user_id: mr_hong.id,
    nation_id: korea.id,
    supul_id: hankyung_supul.id,
    gab_balance: Decimal.from_float(10_000.0),
    }) 

msg_serialized = Poison.encode!(hong_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# hong_entity = change(hong_entity) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!
{:ok, hong_entity} = Business.update_entity(hong_entity, %{registered_no: signature}) 

  
#? 시민 성춘향의 비즈니스 :: Sung's Entity
{:ok, sung_entity} = Business.create_entity(corea, %{
  name: "Sung Chunhyang Entity", 
    supul_name: "연동",
    email: "sung@8211.kr", 
    pasword: "temppass",
    entity_address: "제주시 연동 국수만찬",
    user_id: ms_sung.id,
    nation_id: korea.id,
    supul_id: hanlim_supul.id,
    gab_balance: Decimal.from_float(10_000.0),
    }) 

msg_serialized = Poison.encode!(sung_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# sung_entity = change(sung_entity) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!
{:ok, sung_entity} = Business.update_entity(sung_entity, %{registered_no: signature}) 
     

#? 시민 임꺽정의 비즈니스 :: Lim's Entity
{:ok, lim_entity} = Business.create_entity(corea, %{
  name: "Lim Geukjung Entity", 
    supul_name: "안덕면",
    email: "lim@8255.kr", 
    pasword: "temppass",
    entity_address: "서귀포시 안덕면 77-1",
    user_id: mr_lim.id,
    nation_id: korea.id,
    supul_id: hankyung_supul.id,
    gab_balance: Decimal.from_float(10_000.0), 
    }) 

msg_serialized = Poison.encode!(lim_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# lim_entity = change(lim_entity) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!
{:ok, lim_entity} = Business.update_entity(lim_entity, %{registered_no: signature}) 
    

#? 시민 성춘향의 또 하나의 비즈니스 = Tomi Lunch Box
{:ok, tomi_entity} = Business.create_entity(corea, %{
  name: "Tomi Lunch Box", 
    project: "일반 법인", 
    supul_name: "한림읍",
    pasword: "temppass",
    email: "tomi@3532.kr", 
    entity_address: "제주시 한림읍 11-1",
    user_id: ms_sung.id,
    nation_id: korea.id,
    supul_id: hanlim_supul.id,
    gab_balance: Decimal.from_float(10_000.0),
    }) 

msg_serialized = Poison.encode!(tomi_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# tomi_entity = change(tomi_entity) |> Ecto.Changeset.put_change(:registered_no, signature) |> Repo.update!
{:ok, tomi_entity} = Business.update_entity(tomi_entity, %{registered_no: signature}) 
   

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
# mr_hong = User.changeset_update_entities(mr_hong, [hong_entity])
mr_hong = Accounts.update_entities(mr_hong, [hong_entity])

#? 임꺽정과 그의 비즈니스
# User.changeset_update_entities(mr_lim, [lim_entity])
mr_lim = Accounts.update_entities(mr_lim, [lim_entity])

#? 성춘향과 그녀의 비즈니스들
# User.changeset_update_entities(ms_sung, [tomi_entity,sung_entity])
ms_sung = Accounts.update_entities(ms_sung, [sung_entity, tomi_entity])

#? Corea와 정부 또는 공공 기관들
# User.changeset_update_entities(corea, [kts, gab_korea, gopang_korea])
corea = Accounts.update_entities(corea, [kts, gab_korea, gopang_korea])




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



#? Income Statement
{:ok, kts_is} = IncomeStatements.create_income_statement(kts, %{entity_id: kts.id}) 
{:ok, gab_korea_is} = IncomeStatements.create_income_statement(gab_korea, %{entity_id: gab_korea.id}) 
{:ok, gopang_korea_is} = IncomeStatements.create_income_statement(gopang_korea, %{entity_id: gopang_korea.id}) 
{:ok, hong_entity_is} = IncomeStatements.create_income_statement(hong_entity, %{entity_id: hong_entity.id}) 
{:ok, sung_entity_is} = IncomeStatements.create_income_statement(sung_entity, %{entity_id: sung_entity.id}) 
{:ok, lim_entity_is} = IncomeStatements.create_income_statement(lim_entity, %{entity_id: lim_entity.id}) 
{:ok, tomi_entity_is} = IncomeStatements.create_income_statement(tomi_entity, %{entity_id: tomi_entity.id}) 



#? Balance Sheet
# gopang_korea_BS = #? 국가 교통물류 인프라 
#   Ecto.build_assoc(gopang_korea, :balance_sheet, %BalanceSheet{
#     gab_balance: Decimal.from_float(10_000.0),
#     entity_name: gopang_korea.name,
#     t1s: [%{
#       input_name: gab_korea.name, 
#       input_id: gab_korea.id, 
#       output_name: gopang_korea.name, 
#       output_id: gopang_korea.id, 
#       amount: Decimal.from_float(10_000.00)}],
#     cash: Decimal.from_float(500_000.00),
#   }) \
#   |> Repo.insert!()

{:ok, gopang_korea_BS} = BalanceSheets.create_balance_sheet(gab_korea, %{ 
    gab_balance: Decimal.from_float(10_000.0),
    entity_name: gopang_korea.name,
    t1s: [%{
      input_name: gab_korea.name, 
      input_id: gab_korea.id, 
      output_name: gopang_korea.name, 
      output_id: gopang_korea.id, 
      amount: Decimal.from_float(10_000.00)}],
    cash: Decimal.from_float(500_000.00),
  })


{:ok, gab_korea_BS} = BalanceSheets.create_balance_sheet(gab_korea, %{
      entity_name: gab_korea.name,
      gab_balance: Decimal.from_float(1_000_000.0),
      t1s: [%{
        input_name: korea.name, 
        input_id: korea.id, 
        output_name: gab_korea.name, 
        output_id: gab_korea.id, 
        amount: Decimal.from_float(1_000_000.0),
        }],
      cash: Decimal.from_float(500_000_000.00),
    }) 

{:ok, kts_BS} = BalanceSheets.create_balance_sheet(gab_korea, %{
    gab_balance: Decimal.from_float(10_000.0),
    t1s: [%{
      input_name: gab_korea.name, 
      input_id: gab_korea.id, 
      output_name: kts.name, 
      output_id: kts.id, 
      amount: Decimal.from_float(10_000.0)
      }],
    cash: Decimal.from_float(500_000.00),
  })
  

{:ok, hong_entity_BS} = BalanceSheets.create_balance_sheet(hong_entity, %{
    entity_name: hong_entity.name,
    cash: Decimal.from_float(50_000.00),
    gab_balance: Decimal.from_float(10_000.0),
    t1s: [%{
      input_name: gab_korea.name, 
      input_id: gab_korea.id, 
      output_name: hong_entity.name, 
      output_id: hong_entity.id, 
      amount: Decimal.from_float(10_000.00)}]}) 

{:ok, lim_entity_BS} = BalanceSheets.create_balance_sheet(lim_entity, %{
    entity_name: lim_entity.name,
    cash: Decimal.from_float(50_000.00),
    gab_balance: Decimal.from_float(10_000.0),
    t1s: [%{
      input_name: gab_korea.name, 
      input_id: gab_korea.id, 
      output_name: lim_entity.name, 
      output_id: lim_entity.id, 
      amount: Decimal.from_float(10_000.00)}]})

{:ok, sung_entity_BS} = BalanceSheets.create_balance_sheet(sung_entity, %{
    entity_name: sung_entity.name,
    cash: Decimal.from_float(50_000_000.00),
    gab_balance: Decimal.from_float(10_000.0),
    t1s: [%{
      input_name: gab_korea.name, 
      input_id: gab_korea.id, 
      output_name: sung_entity.name, 
      output_id: sung_entity.id, 
      amount: Decimal.from_float(10_000.00)}]}) 

{:ok, tomi_entity_BS} = BalanceSheets.create_balance_sheet(tomi_entity, %{
    entity_name: tomi_entity.name,
    fixed_assets: [%{building: 1.0}],
    gab_balance: Decimal.from_float(10_000.0),
    t1s: [%{
      input_name: gab_korea.name, 
      input_id: gab_korea.id, 
      output_name: tomi_entity.name, 
      output_id: tomi_entity.id, 
      amount: Decimal.from_float(10_000.00)}]
    }) 
    

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

 
'''

BIZ_CATEGORY & GPC_CODE

'''
alias Demo.Business
alias Demo.Business.BizCategory

for category <- [%{name: "한식 일반 음식점업", standard: "한국표준산업분류표", code: "56111"}, %{name: "김밥 및 기타 간이 음식점업", standard: "한국표준산업분류표", code: "56194"}] do
  Business.create_biz_category!(category)
end


alias Demo.Business
alias Demo.Business.GPCCode
# 분식 = GPCCode.changeset(%GPCCode{name: "분식", code: "345445", standard: "GTIN"}) |> Repo.insert!
# 한식 = GPCCode.changeset(%GPCCode{name: "한식", code: "345446", standard: "GTIN"}) |> Repo.insert!
{:ok, 분식} = Business.create_GPCCode(%{name: "분식", code: "345445", standard: "GTIN"}) 
{:ok, 한식} = Business.create_GPCCode(%{name: "한식", code: "345446", standard: "GTIN"}) 


alias Demo.Business.Product
#? 토미 김밥의 상품
# 김밥 = Product.changeset(%Product{name: "김밥", gpc_code_id: 분식.id, price: 1.0}) |> Repo.insert!
{:ok, 김밥} = Business.create_product(tomi_entity, %{name: "김밥", gpc_code_id: 분식.id, price: 1.0}) 
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
alias Demo.Multimedia.Video
# 한정식_video = Video.changeset(%Video{title: "산채 한정식", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 한정식.id, description: "엄청 맛있데요. 글쎄..."}) |> Repo.insert!
{:ok, 한정식_video} = Multimedia.create_video(한정식, %{title: "산채 한정식", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 한정식.id, description: "엄청 맛있데요. 글쎄..."})
{:ok, 육개장_video} = Multimedia.create_video(육개장, %{title: "육개장", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 육개장.id, description: "엄청 맛있데요. 글쎄..."})
{:ok, 갈비탕_video} = Multimedia.create_video(갈비탕, %{title: "갈비탕", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 갈비탕.id, description: "엄청 맛있데요. 글쎄..."})

{:ok, 김밥_video} = Multimedia.create_video(김밥, %{title: "김밥", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 김밥.id, description: "엄청 맛있데요. 글쎄..."})
{:ok, 떡볶이_video} = Multimedia.create_video(떡볶이, %{title: "떡볶이", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 떡볶이.id, description: "엄청 맛있데요. 글쎄..."})
{:ok, 우동_video} = Multimedia.create_video(우동, %{title: "우동", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 우동.id, description: "엄청 맛있데요. 글쎄..."})





'''
TRANSACTION 1

Transaction between gab_korea_entity and hong_entity.

The price of ABC T1, T2, T3 will be updated every second.
The code below is hard coded. We need write codes for invoice_items with only one item.
'''
alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}
alias Demo.Business.Product
alias Demo.Business


#? From now on, let's write invoice for trade between mr_hong and gab_korea.
#? First, let "krw" a product of hong_entity
{:ok, krw} = Business.create_product(hong_entity, %{
  name: "KRW", price: Decimal.from_float(0.0012)}) 
  
# hong_entity = Entity.changeset_update_products(hong_entity, [krw])

#? prepare transaction between hong_entity and gab_korea. gab_korea will buy krw from hong_entity. 
#? Remember, in a transaction, the one paying ABC is buyer, and the other receiving ABC is seller. 

#? There can be more than one items in an invoice like 짜장 2, 짬뽕 1, 탕수육 1 ...
invoice_items = []

# invoice_item = InvoiceItem.changeset(%InvoiceItem{}, %{item_name: "KRW", product_id: krw.id, price: krw.price, quantity: 20000}) |> Repo.insert!
alias Demo.InvoiceItems
{:ok, invoice_item} = InvoiceItems.create_invoice_item(%{item_name: "KRW", product_id: krw.id, price: krw.price, quantity: 20000})

invoice_items = [invoice_item | invoice_items]


alias Demo.Invoices
{:ok, invoice} = Invoices.create_invoice(%{
  "buyer" => %{"main_name" => gab_korea.name, "main_id" => gab_korea.id},
  "seller" => %{"main_name" => hong_entity.name,"main_id" => hong_entity.id},
  "invoice_items" => invoice_items,
  "fiat_currency" => invoice_item.quantity
})


#? Write Transaction
alias Demo.Transactions
alias Demo.Transactions.Transaction

# {ok, transaction_1} = Transactions.create_transaction(%{
#     buyer: gab_korea.name,
#     seller: hong_entity.name,
#     abc_input_id: gab_korea.id, #? in real transaction, it should be a public addresss of buyer.
#     abc_input_name: gab_korea.name, 
#     abc_output_id: hong_entity.id,  #? in real transaction, it should be a public addresss of seller.
#     abc_output_name: hong_entity.name,  
#     abc_amount: invoice.total,
#     fiat_currency: invoice.fiat_currency
#     }) 

{ok, transaction_1} = Transactions.create_transaction(invoice) 

# #? Association between Transaction and Invoice
# invoice = Ecto.build_assoc(transaction_1, :invoice, invoice) 


'''

Supul

''' 
#? let's pretend the transaction data has been sent to the supuls of traders respectively.
#? Adjust balance_sheet of both.
#? HONG & GAB KOREA
# gab_korea_FR = Repo.preload(gab_korea, [financial_report: :balance_sheet]).financial_report

# gab_korea_BS = gab_korea_FR.balance_sheet
alias Demo.Reports.BalanceSheet
alias Demo.BalanceSheets
gab_korea_BS = BalanceSheet.minus_abc(gab_korea_BS, transaction_1.abc_amount) 



|> \
#     Ecto.Changeset.put_change(
#         # :cash, Decimal.add(gab_korea_BS.cash, Decimal.mult(String.to_integer(item.name), 
#         #     Enum.at(invoice_items, 0).quantity))) |>  \
#         :cash, Decimal.add(gab_korea_BS.cash, transaction_1.fiat_currency) |>  \
#     Ecto.Changeset.put_change(:t1, 
#         Decimal.sub(gab_korea_BS.t1, transaction_1.abc_amount)) |> Repo.update!



#? Hong Gil_Dong
alias Demo.ABC.T1

hong_entity_FR = Repo.preload(hong_entity, [financial_report: :balance_sheet]).financial_report

hong_entity_BS = hong_entity_FR.balance_sheet
hong_entity_BS = change(hong_entity_BS) |> \
    Ecto.Changeset.put_change(
        :cash, Decimal.sub(hong_entity_BS.cash, Decimal.mult(String.to_integer(item.name), 
            Enum.at(invoice_items, 0).quantity))) |> Repo.update!

t1s = [%T1{input: gab_korea.name, output: hong_entity.name, input_id: gab_korea_public_address, output_id: hong_public_address, amount: transaction_1.output_amount}]
hong_entity_BS = change(hong_entity_BS) |> \
    Ecto.Changeset.put_embed(:t1s, t1s) |> Repo.update!

 

'''
TRANSACTION 2
Transaction between hong_entity and tomi_entity
'''

#? write invoice for trade between mr_hong and gab_korea.
item_1 = Item.changeset(%Item{}, %{gpc_code: "ABCDE11133", category: "Food", name: "김밥", price: Decimal.from_float(0.01)}) |> Repo.insert!
item_2 = Item.changeset(%Item{}, %{gpc_code: "ABCDE11134", category: "Food", name: "떡볶이", price: Decimal.from_float(0.02)}) |> Repo.insert!
invoice_items = [%{item_id: item_1.id, quantity: 3}, %{item_id: item_2.id, quantity: 3}]


params = %{
  "buyer" => %{"entity_id" => hong_entity.id, "entity_address" => hong_public_address},
  "seller" => %{"entity_id" => tomi_entity.id, "entity_address" => tomi_public_address},
  "invoice_items" => invoice_items,
}
{:ok, invoice} = Invoice.create(params)
invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!
#? hash_of_invoice = hong_public_sha256 = :crypto.hash(:sha256, invoice)








#? Write Transaction 
transaction_2 = Transaction.changeset(%Transaction{
    hash_of_invoice: "dummy_hash_of_invoice",
    input: gab_korea_public_address, 
    output: hong_public_address,
    output_amount: 0,
    locked: false,
    locking_use_area: ["jejudo_supul"],
    locking_output_entity_catetory: ["food"],
    locking_output_specific_entities: [tomi_public_address]
    }) |> Repo.insert!

transaction_2 = change(transaction_2) |> Ecto.Changeset.put_change(:output_amount, invoice.total) |> Repo.update!

#? Association between Transaction and Invoice
invoice = Ecto.build_assoc(transaction_2, :invoice, invoice) 

'''
Adjust balance_sheet of both.
''' 
#? Hong Gil_Dong
hong_entity_FR = Repo.preload(hong_entity, [financial_report: :balance_sheet]).financial_report

hong_entity_BS = hong_entity_FR.balance_sheet
hong_t1s = hong_entity_BS.t1s

# case Enum.at(hong_t1s, 0).output == hong_public_address do:
    residual_amount = Decimal.sub(Enum.at(hong_t1s, 0).amount, invoice.total)
    [head | hong_t1s] = hong_t1s
    t1s = [%T1{input: hong_public_address, output: hong_public_address, amount: residual_amount}]
    
    hong_entity_BS = change(hong_entity_BS) |> \
    Ecto.Changeset.put_embed(:t1s, t1s) |> Repo.update!
    
    
    tomi_entity_FR = Repo.preload(tomi_entity, [financial_report: :balance_sheet]).financial_report
    tomi_entity_BS = tomi_entity_FR.balance_sheet
    
    t1s = [%T1{input: hong_public_address, output: tomi_public_address, amount: invoice.total}]
    
    hong_entity_BS = change(hong_entity_BS) |> \
        Ecto.Changeset.put_embed(:t1s, t1s) |> Repo.update!
# end








'''

TRANSACTION
Let's assume hong is selected as beneficiary of policy finance.
Transaction between gopang and hong_entity.

'''

alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}
alias Demo.Tickets.Ticket

# ? write invoice for trade between mr_hong and gopang.
item =
  Item.changeset(
    %Item{},
    %{
      product_uuid: tomi_entity.id,
      price: Decimal.from_float(1.0),
    }
  ) \
  |> Repo.insert!()

# ? issue an ticket

ticket =
  Ticket.changeset(%Ticket{}, %{
    departure: tomi_entity.entity_address,
    destination: hong_entity.entity_address,
    departure_time: "2020-06-23 23:50:07",
    arrival_time: "2020-06-24 00:20:07",
    item_id: item.id,
    item_size: [%{width: 10, height: 10, length: 30}],
    item_weight: 980,
    caution: "rotenable",
    gopang_fee: Decimal.from_float(0.1),
  }) \
  |> Repo.insert!()


invoice_items = [
  %{item_id: item.id, quantity: 5.0, item_name: "김밥"},
  %{item_id: item.id, quantity: 0.0}
]

params = %{
  "buyer" => %{"main" => hong_entity.id, "participants" => hong_entity.id},
  "seller" => %{"main" => tomi_entity.id, "participants" => tomi_entity.id},
  "invoice_items" => invoice_items
}

{:ok, invoice} = Invoice.create(params)

# invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!

# ? hash_of_invoice = hong_public_sha256 = :crypto.hash(:sha256, invoice)

'''

Route and Ticket

'''
# ? calculate route, then embed it on the ticket. 


# ? Write Transaction p
alias Demo.Transactions.Transaction
transaction =
  Transaction.changeset(%Transaction{
    abc_input: hong_entity.id,
    abc_output: gopang.id,
    abc_amount: invoice.total,
    items: [%{김밥: 5}],
  }) \
  |> Repo.insert!()

# ? Association between Transaction and Invoice
invoice = Ecto.build_assoc(transaction, :invoice, invoice)
ticket = Ecto.build_assoc(transaction, :ticket, ticket)


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
{:ok, buyer_signature} = ExPublicKey.sign(ts_msg_serialized, hong_rsa_priv_key)
{:ok, seller_signature} = ExPublicKey.sign(ts_msg_serialized, tomi_rsa_priv_key)

# combine payload
payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64(buyer_signature)}|#{Base.url_encode64(seller_signature)}"

#? send the payload to the NEAREST common supul of both buyer and seller. 


'''

SUPUL
Second, the supul_mulet verifies and unserialize the payload from mr_hong. 

'''

alias Demo.Mulets.Mulet
hankyung_mulet = Ecto.build_assoc(hankyung_supul, :mulet, %{current_hash: hankyung_supul.id})

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
  ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig_buyer, hong_rsa_pub_key)

{:ok, sig_valid_seller} =
  ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig_seller, tomi_rsa_pub_key)

# assert(sig_valid)

#? Archieve Tickets
alias Demo.Mulets.TicketStorage
alias Demo.Tickets.Payload
payload_archive = Payload.changeset(%Payload{payload: payload}) |> Repo.insert!
payload_archive = Ecto.build_assoc(hankyung_supul, :payloads, payload_archive)

payload_storage = TicketStorage.changeset(%TicketStorage{}, %{new_payload: payload_archive})



#? recv_msg_unserialized = Poison.Parser.parse!(recv_msg_serialized, %{})
# assert(msg == recv_msg_unserialized)




'''

Adjust balance_sheet of both.

'''
alias Demo.ABC.T1

# ? gopang
new_t1s =
  Enum.map(gopang_BS.t1s, fn elem ->
    Map.update!(elem, :amount, fn curr_value -> Decimal.add(curr_value, ticket.gopang_fee) end)
  end)

gopang_BS = change(gopang_BS) |> Ecto.Changeset.put_change(:t1s, new_t1s) |> Repo.update!()


# ? mr_hong
residual_amount = Decimal.sub(Enum.at(hong_entity_BS.t1s, 0).amount, transaction.abc_amount)
new_t1s = [%T1{input: hong_entity.id, output: hong_entity.id, amount: residual_amount}]
hong_entity_BS = change(hong_entity_BS) |> Ecto.Changeset.put_embed(:t1s, new_t1s) |> Repo.update!

# ? tomi
new_t1s = [%T1{input: hong_entity.id, output: tomi_entity.id, amount: transaction.abc_amount} | tomi_entity_BS.t1s]
tomi_entity_BS = change(tomi_entity_BS) |> Ecto.Changeset.put_embed(:t1s, new_t1s) |> Repo.update!


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

