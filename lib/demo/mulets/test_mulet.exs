import Ecto.Query
import Ecto.Changeset
alias Demo.Repo

#? init nations
alias Demo.Nations.Nation

korea = Nation.changeset(%Nation{}, %{name: "South Korea"}) |> Repo.insert!
usa = Nation.changeset(%Nation{}, %{name: "USA"}) |> Repo.insert!


#? init supuls. For example, Korea will have about 5,000 supuls.
alias Demo.Supuls.GlobalSupul
alias Demo.Supuls.NationSupul
alias Demo.Supuls.StateSupul
alias Demo.Supuls.Supul

#? init supuls
global_supul = GlobalSupul.changeset(%GlobalSupul{}, %{name: "Global Supul", supul_code: 0x00000000}) |> Repo.insert!
korea_supul = NationSupul.changeset(%NationSupul{}, %{name: "Korea Supul", supul_code: 0x52000000}) |> Repo.insert!
jejudo_supul = StateSupul.changeset(%StateSupul{}, %{name: "Jejudo State Supul", supul_code: 0x01434500}) |> Repo.insert!
hankyung_supul = Supul.changeset(%Supul{}, %{name: "Hankyung_County", supul_code: 0x01434501}) |> Repo.insert!


#? init users
alias Demo.Users.User

mr_hong = User.changeset(%User{}, %{name: "Hong Gildong", email: "hong_gil_dong@82345.kr"}) |> Repo.insert!
ms_sung = User.changeset(%User{}, %{name: "Sung Chunhyang", email: "sung_chun_hyang@82345.kr"}) |> Repo.insert!

#? init entities
alias Demo.Entities.Entity

hong_entity = Entity.changeset( \
    %Entity{}, %{name: "Hong Gildong Entity", email: "hong_gil_dong@82345.kr"}) \
    |> Repo.insert!
tomi_entity = Entity.changeset( \
    %Entity{}, %{name: "Tomi Kimbab", email: "tomi@82345.kr"}) \
    |> Repo.insert!

#? build_assoc user and entity
Repo.preload(hong_entity, [:users]) \
    |> Ecto.Changeset.change() \
    |> Ecto.Changeset.put_assoc(:users, [mr_hong]) \
    |> Repo.update!
Repo.preload(tomi_entity, [:users]) \
    |> Ecto.Changeset.change() \
    |> Ecto.Changeset.put_assoc(:users, [ms_sung]) \
    |> Repo.update!

#? build_assoc entity and supul
Repo.preload(hankyung_supul, [:entities]) \
    |> Ecto.Changeset.change() \
    |> Ecto.Changeset.put_assoc(:entities, [hong_entity, tomi_entity]) \
    |> Repo.update! 


'''
Mulet

** use the code below to load invoice file **
## from https://www.poeticoding.com/hashing-a-file-in-elixir/?utm_source=reddit&utm_campaign=reddit_elixir_677 

hash_ref = :crypto.hash_init(:sha256)
    
File.stream!(file_path)
|> Enum.reduce(hash_ref, fn chunk, prev_ref-> 
  new_ref = :crypto.hash_update(prev_ref, chunk)
  new_ref
end)
|> :crypto.hash_final()
|> Base.encode16()
|> String.downcase()
'''

#? make a mulet for Hangkyung Supul. Remember every supul, state_supul, nation_supul and global_supul has one, only one mulet.
alias Demo.Mulets.Mulet
hankyung_mulet = Ecto.build_assoc(hankyung_supul, :mulet, %{current_hash: hankyung_supul.id}) 

#? build_assoc jejudo_mulet with jejudo
jejudo_mulet = Ecto.build_assoc(jejudo_supul, :mulet, %{current_hash: jejudo_supul.id}) 

#? build_assoc korea_mulet with korea
korea_mulet = Ecto.build_assoc(korea_supul, :mulet, %{current_hash: korea_supul.id}) 

#? build_assoc global_mulet with global
global_mulet = Ecto.build_assoc(global_supul, :mulet, %{current_hash: global_supul.id}) 

#? let mulet work.
#? hankyung_mulet
invoice_hash = 
    :crypto.hash(:sha256, "Put hong's new invoice here") \
    |> Base.encode16() \
    |> String.downcase()

hankyung_mulet = Mulet.changeset(hankyung_mulet, %{invoice_hash: invoice_hash})

#? send hankyung_mulet.current_hash to the jejudo_mulet
invoice_hash = hankyung_mulet.current_hash
jejudo_mulet = Mulet.changeset(jejudo_mulet, %{invoice_hash: invoice_hash})

#? korea_mulet
invoice_hash = jejudo_mulet.current_hash
korea_mulet = Mulet.changeset(korea_mulet, %{invoice_hash: invoice_hash})

#? global_mulet
invoice_hash = jejudo_mulet.current_hash
global_mulet = Mulet.changeset(global_mulet, %{invoice_hash: invoice_hash})


'''
Sil
'''

#? entity report
alias Demo.Reports.FinancialReport
hong_report = FinancialReport.changeset(%FinancialReport{}, %{entity_id: hong_entity.id}) |> Repo.insert!
tomi_report = FinancialReport.changeset(%FinancialReport{}, %{entity_id: tomi_entity.id}) |> Repo.insert!

#? attatch a sil to an entity.
alias Demo.Sils.Sil
hong_sil = Ecto.build_assoc(hong_entity, :sil, %{current_hash: hong_entity.id})

report_hash = 
    :crypto.hash(:sha256, "Put hong's updated financial report here") \
    |> Base.encode16() \
    |> String.downcase()

hong_sil = Sil.changeset(hong_sil, %{report_hash: report_hash})

hong_report = change(hong_report) \
    |> Ecto.Changeset.put_change(:current_hash, report_hash) \
    |> Repo.update!
