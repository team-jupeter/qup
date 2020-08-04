import Ecto.Query
import Ecto.Changeset
alias Demo.Repo


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
 
#? GLOBAL SUPUL
alias Demo.GlobalSupuls
alias Demo.NationSupuls
alias Demo.StateSupuls
alias Demo.Supuls

{:ok, global_supul} = GlobalSupuls.create_global_supul(%{
  name: "글로벌 수풀", 
  pasword: "p",
  email: "golobal@un", 
  gab_balance: Decimal.from_float(10_000.0),
  current_hash: "global"
  }) 

msg_serialized = Poison.encode!(global_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, global_supul} = GlobalSupuls.update_global_supul(global_supul, %{auth_code: signature}) 


'''
NATION
'''
alias Demo.Nations
{:ok, korea} = Nations.create_nation(%{
  name: "South Korea", 
  global_supul: global_supul,
  }) 
 
#? private and pulbic key of korea
korea_rsa_priv_key = ExPublicKey.load!("./keys/korea_private_key.pem")
korea_rsa_pub_key = ExPublicKey.load!("./keys/korea_public_key.pem")
   



'''

SUPUL

'''

#? KOREA SUPUL
{:ok, korea_supul} = NationSupuls.create_nation_supul(%{
  type: "Nation Supul", 
  nation_supul_code: "82",
  name: "한국", 
  global_supul: global_supul, 
  global_supul_id: global_supul.id,
  current_hash: "korea"
    }) 

msg_serialized = Poison.encode!(korea_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, korea_supul} = NationSupuls.update_nation_supul(korea_supul, %{auth_code: signature}) 

{:ok, korea} = Nations.update_nation(korea, %{nation_supul: korea_supul})

#? SEOUL SUPUL
{:ok, seoul_supul} = StateSupuls.create_state_supul(%{
  name: "서울", 
  type: "State Supul", 
  state_supul_code: "8201",
  nation_supul: korea_supul, 
  current_hash: "seoul"
    }) 

msg_serialized = Poison.encode!(seoul_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, seoul_supul} = StateSupuls.update_state_supul(seoul_supul, %{auth_code: signature}) 
   
#? JEJUDO SUPUL
{:ok, jejudo_supul} = StateSupuls.create_state_supul(%{
  name: "제주도", 
  type: "State Supul", 
  state_supul_code: "8213",
  nation_supul: korea_supul, 
  current_hash: "jejudo"
    }) 

msg_serialized = Poison.encode!(jejudo_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, jejudo_supul} = StateSupuls.update_state_supul(jejudo_supul, %{auth_code: signature}) 
   
#? HANKYUNG SUPUL
{:ok, hankyung_supul} = Supuls.create_supul(%{
  name: "한경면", 
  state_name: "제주도", 
  nation_name: "한국",
  type: "Unit Supul", 
  supul_code: "821311",
  state_supul: jejudo_supul,
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
    name: "한림읍", 
    state_name: "제주도", 
    nation_name: "한국",
    type: "Unit Supul", 
    supul_code: "821312",
    state_supul: jejudo_supul,
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
    name: "서귀포시", 
    state_name: "제주도", 
    nation_name: "한국",
    type: "Unit Supul",  
    supul_code: "821313",
    state_supul: jejudo_supul,
    current_hash: "seoguipo"
    }) 

msg_serialized = Poison.encode!(seoguipo_supul)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, seoguipo_supul} = Supuls.update_supul(seoguipo_supul, %{auth_code: signature}) 
   
# Repo.preload(seoguipo_supul, :account_book).account_book
# Repo.preload(seoguipo_supul, :income_statement).income_statement

'''
USER 

'''
alias Demo.Accounts
{:ok, corea} = Accounts.create_corea(%{
  name: "COREA", 
  username: "corea", 
  nation: korea,
  password: "p",
  email: "corea@un",
  supul: hankyung_supul, 
  default_family: true,
  }) 

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
  username: "mr_hong",
  default_family: true, 
  })

# alias Demo.Families
#  {:ok, new_family} = Families.create_family(%{house_holder_name: "Jupeter"}) 
#  {:ok, mr_hong} = Accounts.update_user_family(mr_hong, %{family: new_family})

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
  username: "ms_sung",
  default_family: true, 
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
  auth_code: "54051898822kr",
  birth_date: ~N[1970-11-11 09:14:09],
  username: "mr_lim",
  default_family: true, 
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
  supul_name: "서귀포시",
  email: "lee@0000.kr",
  birth_date: ~N[2000-05-05 06:14:09],
  family_code: nil, 
  username: "mr_lee",
  default_family: true, 
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
alias Demo.Groups
{:ok, korea_group} = Groups.create_group(%{name: "Korean Public Group"})

alias Demo.Entities

#? 국세청 korea's Entity == a governmental organization  
{:ok, kts} = Entities.create_public_entity(%{
  name: "Korea Tax Service", 
  supul: hankyung_supul,
  nation: korea,
  user: corea,
  email: "kts@kr",
  group: korea_group,
  unique_digits: "82111110",
  tels: ["82111110"],
  }) 
  
  
  #? Korea authorizes its governmental organizations.  
  msg_serialized = Poison.encode!(kts)
  ts = DateTime.utc_now() |> DateTime.to_unix()
  ts_msg_serialized = "#{ts}|#{msg_serialized}"
  {:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
  signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
  # kts = change(kts) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
  {:ok, kts} = Entities.update_entity(kts, %{auth_code: signature}) 
  
  

#? 국가 금융 인프라 Korea's Entity == a governmental organization  
{:ok, gab_korea} = Entities.create_public_entity(%{
  type: "public",
  name: "GAB Korea", 
  supul: hankyung_supul,
  nation: korea,
  user: corea,
  pasword: "p",
  email: "gab_korea@kr",
  group: korea_group,
  gab_balance: Decimal.from_float(100000.0),
  unique_digits: "82111100",
  tels: ["82111100"],
  })

msg_serialized = Poison.encode!(gab_korea)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# gab_korea = change(gab_korea) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, gab_korea} = Entities.update_entity(gab_korea, %{auth_code: signature}) 

alias Demo.Entities

#? 국가 교통물류 인프라 Korea's Entity == a governmental organization  
{:ok, gopang_korea} = Entities.create_public_entity(%{
  type: "public",
  name: "Gopang", 
  user: corea, 
  supul: hankyung_supul,
  nation: korea,
  pasword: "temppass",
  email: "gopang_korea@kr",
  group: korea_group,
  gab_balance: Decimal.from_float(0.0),
  unique_digits: "8211111111",
  telephones: ["8211111111"],
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
  type: "default",
  name: "Hong Entity", 
  user: mr_hong, 
  pasword: "temppass",
  email: "hong@0000.kr", 
  entity_address: "제주시 한경면 20-1 해거름전망대",
  gab_balance: Decimal.from_float(0.0),
  unique_digits: "8211111112",
  tels: ["8211111112"],
  }) 

{:ok, mr_hong} =  Demo.Accounts.update_user(mr_hong, %{default_entity_id: hong_entity.id})  

msg_serialized = Poison.encode!(hong_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, hong_entity} = Entities.update_entity(hong_entity, %{auth_code: signature}) 

  
#? 시민 성춘향의 비즈니스 :: Sung's Entity
{:ok, sung_entity} = Entities.create_default_entity(ms_sung, %{
  type: "default",
  name: "Sung Entity", 
  user: ms_sung,
  email: "sung@0000.kr", 
  pasword: "temppass",
  gab_balance: Decimal.from_float(0.0),
  unique_digits: "8211111113",
  tels: ["8211111113"],
  }) 

  {:ok, ms_sung} =  Demo.Accounts.update_user(ms_sung, %{default_entity_id: sung_entity.id})  

msg_serialized = Poison.encode!(sung_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, sung_entity} = Entities.update_entity(sung_entity, %{auth_code: signature}) 
     

#? 시민 임꺽정의 비즈니스 :: Lim's Entity
{:ok, lim_entity} = Entities.create_default_entity(mr_lim, %{
  type: "default",
  name: "Lim Entity", 
  user: mr_lim,
  email: "lim@0000.kr", 
  pasword: "temppass",
  user_id: mr_lim.id,
  gab_balance: Decimal.from_float(0.0),
  unique_digits: "8211111114",
  tels: ["8211111114"],
  }) 
  {:ok, mr_lim} =  Demo.Accounts.update_user(mr_lim, %{default_entity_id: lim_entity.id})  

msg_serialized = Poison.encode!(lim_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# lim_entity = change(lim_entity) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, lim_entity} = Entities.update_entity(lim_entity, %{auth_code: signature}) 
    
#? 시민 이몽룡의 비즈니스 :: Lee's Entity
{:ok, lee_entity} = Entities.create_default_entity(mr_lee, %{
  type: "default",
  name: "Lee Entity", 
  user: mr_lee,
  email: "lee@0000.kr", 
  pasword: "temppass",
  user_id: mr_lee.id,
  gab_balance: Decimal.from_float(0.0),
  default_entity: true,
  unique_digits: "8211111115",
  tels: ["8211111115"],
  }) 

{:ok, mr_lee} =  Demo.Accounts.update_user(mr_lee, %{default_entity_id: lee_entity.id})  

msg_serialized = Poison.encode!(lee_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# lee_entity = change(lim_entity) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, lee_entity} = Entities.update_entity(lee_entity, %{auth_code: signature}) 
    

#? 시민 성춘향의 또 하나의 비즈니스 = Tomi Lunch Box
{:ok, tomi_entity} = Entities.create_private_entity(%{
  type: "private",
  name: "토미 김밥", 
  user: ms_sung,
  supul: hanlim_supul,
  nation: korea,
  project: "일반 법인", 
  supul_name: "한림읍",
  pasword: "temppass",
  email: "tomi@3532.kr", 
  entity_address: "제주시 한림읍 11-1",
  gab_balance: Decimal.from_float(0.0),
  default_group: true,
  group_name: "Sung Group",
  group_type: "Private Group",
  unique_digits: "8211111116",
  tels: ["8211111116"],
  }) 

msg_serialized = Poison.encode!(tomi_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# tomi_entity = change(tomi_entity) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, tomi_entity} = Entities.update_entity(tomi_entity, %{auth_code: signature}) 

#? 임꺽정의 또 하나의 비즈니스 = 산채 비빔밥 

{:ok, sanche_entity} = Entities.create_private_entity(%{
  type: "private",
  name: "산채", 
  user: mr_lim, 
  supul: hankyung_supul,
  nation: korea,
  project: "일반 법인", 
  supul_name: "한경면",
  pasword: "temppass",
  email: "sanche@3532.kr", 
  entity_address: "제주시 한경면 11-1",
  gab_balance: Decimal.from_float(0.0),
  default_group: true,
  group_name: "Lim Group",
  group_type: "Private Group",
  unique_digits: "8211111117",
  tels: ["8211111117"],
  }) 

msg_serialized = Poison.encode!(sanche_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# sanche_entity = change(sanche_entity) |> Ecto.Changeset.put_change(:auth_code, signature) |> Repo.update!
{:ok, sanche_entity} = Entities.update_entity(sanche_entity, %{auth_code: signature}) 

#? 이몽룡의 또 하나의 비즈니스 = 사또 아카테미 

{:ok, sato_entity} = Entities.create_private_entity(%{
  type: "private",
  name: "사또 학원", 
  user: mr_lee,
  supul: seoguipo_supul,
  nation: korea,
  project: "일반 법인", 
  supul_name: "서귀포시",
  pasword: "temppass",
  email: "sato@3532.kr", 
  entity_address: "서귀포시 11-1",
  gab_balance: Decimal.from_float(0.0),
  default_group: true,
  group_name: "Lee Group",
  group_type: "Private Group",
  unique_digits: "8211111118",
  tels: ["8211111118"],
  }) 

msg_serialized = Poison.encode!(sato_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, sato_entity} = Entities.update_entity(sato_entity, %{auth_code: signature}) 

#? 이몽룡의 또 하나의 비즈니스 = 사또 아카테미 

{:ok, ebang_entity} = Entities.create_private_entity(%{
  type: "private",
  name: "이방 학원", 
  user: mr_lee,
  supul: seoguipo_supul,
  nation: korea,
  project: "일반 법인", 
  supul_name: "서귀포시",
  pasword: "temppass",
  email: "sato@3538.kr", 
  entity_address: "서귀포시 11-1",
  gab_balance: Decimal.from_float(0.0),
  default_group: true,
  group_name: "Lee Group",
  group_type: "Private Group",
  unique_digits: "8211111119",
  tels: ["8211111119"],
  }) 

msg_serialized = Poison.encode!(ebang_entity)
ts = DateTime.utc_now() |> DateTime.to_unix()
ts_msg_serialized = "#{ts}|#{msg_serialized}"
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()

{:ok, ebang_entity} = Entities.update_entity(ebang_entity, %{auth_code: signature}) 

# alias Demo.Transactions.Transaction
# alias Demo.Invoices.{Item, Invoice, InvoiceItem}
# alias Demo.Products.Product


#? From now on, let's write invoice for trade between mr_hong and gab_korea.
#? First, let "krw" a product of hong_entity
alias Demo.Products
Products.create_product(gab_korea, %{
  name: "T1", 
  price: 1000.0,
  }) 
  
Products.create_product(gab_korea, %{
  name: "T2", 
  price: 1000.0,
  }) 
  

alias Demo.Entities.BizCategory

for category <- [%{name: "한식 일반 음식점업", standard: "한국표준산업분류표", code: "56111"}, %{name: "김밥 및 기타 간이 음식점업", standard: "한국표준산업분류표", code: "56194"}] do
  Entities.create_biz_category!(category)
end


alias Demo.Products.GPCCode
# 분식 = GPCCode.changeset(%GPCCode{name: "분식", code: "345445", standard: "GTIN"}) |> Repo.insert!
# 한식 = GPCCode.changeset(%GPCCode{name: "한식", code: "345446", standard: "GTIN"}) |> Repo.insert!
{:ok, 분식} = Products.create_GPCCode(%{name: "분식", code: "345445", standard: "GTIN"}) 
{:ok, 한식} = Products.create_GPCCode(%{name: "한식", code: "345446", standard: "GTIN"}) 


alias Demo.Products.Product
#? 토미 김밥의 상품
# 김밥 = Product.changeset(%Product{name: "김밥", gpc_code_id: 분식.id, price: 1.0}) |> Repo.insert!
{:ok, 김밥} = Products.create_product(tomi_entity, %{
  name: "김밥", 
  gpc_code_id: 분식.id, 
  price: 1.0
  }) 
{:ok, 떡볶이} =  Products.create_product(tomi_entity, %{name: "떡볶이", gpc_code_id: 분식.id, price: 1.5}) 
{:ok, 우동} = Products.create_product(tomi_entity, %{name: "우동", gpc_code_id: 분식.id, price: 1.5}) 


#? 임꺽정 산채의 상품
{:ok, 한정식} = Products.create_product(sanche_entity, %{name: "한정식", gpc_code_id: 한식.id, price: 5.0})
{:ok, 육개장} = Products.create_product(sanche_entity, %{name: "육개장", gpc_code_id: 한식.id, price: 3.5})
{:ok, 갈비탕} = Products.create_product(sanche_entity, %{name: "갈비탕", gpc_code_id: 한식.id, price: 3.5})

 
#? 이몽룡 이방 학원의 상품
{:ok, 중국어} = Products.create_product(ebang_entity, %{name: "중국어", gpc_code_id: 한식.id, price: 5.0})
{:ok, 곤장} = Products.create_product(ebang_entity, %{name: "곤장", gpc_code_id: 한식.id, price: 3.5})
{:ok, 아부하기} = Products.create_product(ebang_entity, %{name: "아부하기", gpc_code_id: 한식.id, price: 3.5})
 
#? 이몽룡 사또 학원의 상품
{:ok, 컴퓨터} = Products.create_product(ebang_entity, %{name: "컴퓨터", gpc_code_id: 한식.id, price: 5.0})
{:ok, 폭탄주} = Products.create_product(ebang_entity, %{name: "폭탄주", gpc_code_id: 한식.id, price: 3.5})
{:ok, 팔자걸음} = Products.create_product(ebang_entity, %{name: "팔자걸음", gpc_code_id: 한식.id, price: 3.5})

 

alias Demo.Multimedia
# 한정식_video = Video.changeset(%Video{title: "산채 한정식", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 한정식.id, description: "엄청 맛있데요. 글쎄..."}) |> Repo.insert!
{:ok, 한정식_video} = Multimedia.create_video(한정식, %{title: "산채 한정식", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 한정식.id, description: "엄청 맛있데요. 글쎄..."})
{:ok, 육개장_video} = Multimedia.create_video(육개장, %{title: "육개장", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 육개장.id, description: "엄청 맛있데요. 글쎄..."})
{:ok, 갈비탕_video} = Multimedia.create_video(갈비탕, %{title: "갈비탕", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 갈비탕.id, description: "엄청 맛있데요. 글쎄..."})

{:ok, 김밥_video} = Multimedia.create_video(김밥, %{title: "김밥", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 김밥.id, description: "엄청 맛있데요. 글쎄..."})
{:ok, 떡볶이_video} = Multimedia.create_video(떡볶이, %{title: "떡볶이", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 떡볶이.id, description: "엄청 맛있데요. 글쎄..."})
{:ok, 우동_video} = Multimedia.create_video(우동, %{title: "우동", url: "https://www.youtube.com/watch?v=mskMTVSUKX8", product_id: 우동.id, description: "엄청 맛있데요. 글쎄..."})

#? 계좌 
Products.create_product(hong_entity, %{name: "mr_hong@0000.kr", unique_digits: "8211111112", tel: "8211111112", amount: 0})
Products.create_product(sung_entity, %{name: "ms_sung@0000.kr", unique_digits: "8211111113", tel: "8211111113", amount: 0})
Products.create_product(lim_entity, %{name: "mr_lim@0000.kr", unique_digits: "8211111114", tel: "8211111114", amount: 0})
Products.create_product(lee_entity, %{name: "Money Transfer", unique_digits: "8211111115", tel: "8211111115", amount: 0})

 

'''
EVENT
ms_sung married mr_lee.
''' 

#? a new family
alias Demo.Weddings
#? hard coded bride_private_key, groom_private_key

{:ok, wedding} = Weddings.create_wedding(%{
  type: "wedding", bride_name: "이몽룡", bride_email: mr_lee.email, 
  groom_name: "성춘향", groom_email: ms_sung.email
  })

# {:ok, wedding} = Weddings.create_wedding(%{
#   type: "wedding", bride_name: "임꺽정", bride_email: mr_lim.email, 
#   groom_name: "홍길동", groom_email: mr_hong.email
#   })
  
bride_private_key = ExPublicKey.load!("./keys/lee_private_key.pem")
groom_private_key = ExPublicKey.load!("./keys/sung_private_key.pem")

alias Demo.Events
Events.create_event(wedding, bride_private_key, groom_private_key)

alias Demo.Families.Family
lee_family = Repo.all(from f in Family, where: f.husband_id == ^mr_lee.id, select: f)  

# #? Korea authorizeslee_family as her citizen.
# msg_serialized = Poison.encode!(lee_family)
# ts = DateTime.utc_now() |> DateTime.to_unix()
# ts_msg_serialized = "#{ts}|#{msg_serialized}"
# {:ok, signature} = ExPublicKey.sign(ts_msg_serialized, korea_rsa_priv_key)
# signature = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
# {:ok,lee_family} = Families.update_family(lee_family, %{auth_code: signature}) 
    
  


'''
[] \\ %{}  
'''

'''
TEST
wedding = Repo.preload(lee_family, :wedding).wedding
openhashes = Repo.preload(wedding, :openhashes).openhashes
'''




'''
TRANSACTION 1

Transaction between gab_korea_entity and hong_entity.

The price of ABC T1, T2, T3 will be updated every second.
The code below is hard coded. We need write codes for invoice_items with only one item.
'''


'''
SET DEFAULT ENTITY OF EACH USER
'''
# {:ok, mr_hong} = Accounts.update_user(mr_hong, %{default_entity_id: hong_entity.id, default_entity_name: "hong_entity"}) 
# {:ok, ms_sung} = Accounts.update_user(ms_sung, %{default_entity_id: sung_entity.id, default_entity_name: "sung_entity"}) 
# {:ok, mr_lim} = Accounts.update_user(mr_lim, %{default_entity_id: lim_entity.id, default_entity_name: "lim_entity"}) 
# {:ok, mr_lee} = Accounts.update_user(mr_lee, %{default_entity_id: lee_entity.id, default_entity_name: "lee_entity"}) 



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






# ? prepare financial statements for entities.
#? Balance Sheet
alias Demo.BalanceSheets
alias Demo.ABC.T1
#? 국세청 
new_ts =  %{ts: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: kts.name, 
  output_id: kts.id, 
  amount: Decimal.from_float(100.0),
  }}

BalanceSheets.add_ts(kts.balance_sheet, new_ts)  

#? 국가 물류 인프라  
new_ts = %{ts: %T1{
  input_name: gab_korea.name, 
  input_id: gab_korea.id, 
  output_name: gopang_korea.name, 
  output_id: gopang_korea.id, 
  amount: Decimal.from_float(100.0)}}

BalanceSheets.add_ts(gopang_korea.balance_sheet, new_ts)  

#? 국가 금융 인프라
new_ts =  %{ts: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: gab_korea.name, 
  output_id: gab_korea.id, 
  amount: Decimal.from_float(100.0),
  }}

BalanceSheets.add_ts(gab_korea.balance_sheet, new_ts)  


#? 홍길동 1인 법인
new_ts =  %{ts: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: hong_entity.name, 
  output_id: hong_entity.id, 
  amount: Decimal.from_float(100.0),
  }}

BalanceSheets.add_ts(hong_entity.balance_sheet, new_ts)  

#? 임꺽정 1인 법인
new_ts =  %{ts: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: lim_entity.name, 
  output_id: lim_entity.id, 
  amount: Decimal.from_float(100.0),
  }}

BalanceSheets.add_ts(lim_entity.balance_sheet, new_ts)  

#? 성춘향 1인 법인
new_ts =  %{ts: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: sung_entity.name, 
  output_id: sung_entity.id, 
  amount: Decimal.from_float(100.0),
  }}

BalanceSheets.add_ts(sung_entity.balance_sheet, new_ts)  

#? 이몽룡 1인 법인
new_ts =  %{ts: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: lee_entity.name, 
  output_id: lee_entity.id, 
  amount: Decimal.from_float(100.0),
  }}

BalanceSheets.add_ts(lee_entity.balance_sheet, new_ts)  

#? 토미 도시락 일반 법인
new_ts =  %{ts: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: tomi_entity.name, 
  output_id: tomi_entity.id, 
  amount: Decimal.from_float(100.0),
  }}

tomi_entity_BS = BalanceSheets.add_ts(tomi_entity.balance_sheet, new_ts)  

#? 이방 학원 
new_ts =  %{ts: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: ebang_entity.name, 
  output_id: ebang_entity.id, 
  amount: Decimal.from_float(100.0),
  }}

ebang_entity_BS = BalanceSheets.add_ts(ebang_entity.balance_sheet, new_ts)  

#? 사또 학원 
new_ts =  %{ts: %T1{
  input_name: korea.name, 
  input_id: korea.id, 
  output_name: sato_entity.name, 
  output_id: sato_entity.id, 
  amount: Decimal.from_float(100.0),
  }}

sato_entity_BS = BalanceSheets.add_ts(sato_entity.balance_sheet, new_ts)  



# #? Hankyung Supul
# new_ts =  %{ts: %T1{
#   input_name: korea.name, 
#   input_id: korea.id, 
#   output_name: hankyung_supul.name, 
#   output_id: hankyung_supul.id, 
#   amount: Decimal.from_float(100.0),
#   }}

# hankyung_supul_BS = BalanceSheets.add_ts(hankyung_supul.balance_sheet, new_ts) 

# #? Hanlim Supul
# new_ts =  %{ts: %T1{
#   input_name: korea.name, 
#   input_id: korea.id, 
#   output_name: hanlim_supul.name, 
#   output_id: hanlim_supul.id, 
#   amount: Decimal.from_float(100.0),
#   }}

# hanlim_supul_BS = BalanceSheets.add_ts(hanlim_supul.balance_sheet, new_ts)  

# #? Seoguipo Supul
# new_ts =  %{ts: %T1{
#   input_name: korea.name, 
#   input_id: korea.id, 
#   output_name: seoguipo_supul.name, 
#   output_id: seoguipo_supul.id, 
#   amount: Decimal.from_float(100.0),
#   }}

# seoguipo_supul_BS = BalanceSheets.add_ts(seoguipo_supul.balance_sheet, new_ts)  

# #? Seoul Supul
# new_ts =  %{ts: %T1{
#   input_name: korea.name, 
#   input_id: korea.id, 
#   output_name: seoul_supul.name, 
#   output_id: seoul_supul.id, 
#   amount: Decimal.from_float(100.0),
#   }}
# seoul_supul_BS = BalanceSheets.add_ts(seoul_supul.balance_sheet, new_ts)  

# #? Jejudo Supul
# new_ts =  %{ts: %T1{
#   input_name: korea.name, 
#   input_id: korea.id, 
#   output_name: jejudo_supul.name, 
#   output_id: jejudo_supul.id, 
#   amount: Decimal.from_float(100.0),
#   }}

# jejudo_supul_BS = BalanceSheets.add_ts(jejudo_supul.balance_sheet, new_ts)  

    
# #? Korea Supul
# new_ts =  %{ts: %T1{
#   input_name: korea.name, 
#   input_id: korea.id, 
#   output_name: korea_supul.name, 
#   output_id: korea_supul.id, 
#   amount: Decimal.from_float(100.0),
#   }}

# korea_supul_BS = BalanceSheets.add_ts(korea_supul.balance_sheet, new_ts)  
# '''
    
