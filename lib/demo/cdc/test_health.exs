import Ecto.Query
import Ecto.Changeset
alias Demo.Repo


alias Demo.Nations.Nation

nation1 = Nation.changeset(%Nation{}, %{name: "South Korea"})
korea = Repo.insert!(nation1)
nation2 = Nation.changeset(%Nation{}, %{name: "USA"})
usa = Repo.insert!(nation2)

nation_ids = Enum.map(Repo.all(Nation), fn(nation)-> nation.id end)
{korea_id, usa_id} = {Enum.at(nation_ids, 0), Enum.at(nation_ids, 1) }

nations = Repo.all(Nation)
Repo.preload nations, :taxation

#? init supuls. For example, Korea will have about 4,000 supuls.
alias Demo.Supuls.Supul

hankyung_supul = %Supul{name: "Hankyung_County", nation_id: korea_id, supul_code: 0x52070104} |> Repo.insert!
hallim_supul = %Supul{name: "Hallim_County", nation_id: korea_id, supul_code: 0x52070102} |> Repo.insert!
orange_supul = %Supul{name: "Orange_County", nation_id: usa_id, supul_code: 0x01171124} |> Repo.insert!

supul_ids = Enum.map(Repo.all(Supul), fn(supul)-> supul.id end)
{hankyung_supul_id, orange_supul_id} = {Enum.at(supul_ids, 0), Enum.at(supul_ids, 1)}


#? init users
alias Demo.Accounts.User

[gildong, chunhyang, trump] = [%User{nation_id: korea_id, name: "Mr.Hong", email: "mr_hong@2331.kr", type: "human"}, %User{nation_id: korea_id, name: "Ms.Sung", email: "ms_sung@1335.kr", type: "human"}, %User{nation_id: usa_id, name: "Donald Trump", email: "trump@1335.us", type: "human"}]
mr_hong = Repo.insert!(gildong)
ms_sung = Repo.insert!(chunhyang)
trump = Repo.insert!(trump)

user_ids = Enum.map(Repo.all(User), fn(user)-> user.id end)
{hong_id, sung_id, trump_id} = {Enum.at(user_ids, 0), Enum.at(user_ids, 1), Enum.at(user_ids, 2)}


#? init certificates
alias Demo.Certificates.Certificate

doctor_cert_1 = %Certificate{name: "Diagnostic Doctor", issued_by: korea_id, issued_to: mr_hong.id, issued_date: ~N[2020-05-14 21:30:00], valid_until: ~N[2025-05-14 21:30:00]}

#? add doctor certificate to a user
doctor_cert_1 = Ecto.build_assoc(mr_hong, :certificates, doctor_cert_1)
Repo.insert!(doctor_cert_1)
Repo.preload(mr_hong, :certificates)


# #? init clinics
# alias Demo.Clinics.Clinic

# clinic_jeju = Repo.insert!(%Clinic{name: "Jeju Jeil Clinic", license: "ADB11123", nation_id: korea_id, ceo: sung_id, specialty: "Family Medicine"})


#? add a few doctors to the clinic
alias Demo.Entities.Entity

jeil_clinic = Entity.changeset(
  %Entity{},
  %{
    category: "clinic",
    name: "Jeju Jeil Clinic",
    nation_id: korea_id,
    email: "dr_hong@82345.kr",
    }) |> Repo.insert!


#? init a few doctors
jeil_clinic = Repo.preload(jeil_clinic, [:users])
jeil_clinic_cs = Ecto.Changeset.change(jeil_clinic) |> Ecto.Changeset.put_assoc(:users, [mr_hong, ms_sung])
jeil_clinic = Repo.update!(jeil_clinic_cs)



#? init health_reports
alias Demo.Reports.HealthReport
alias Demo.Reports.Prescription
alias Demo.Reports.Treatment

trump_health_report = Repo.insert!(%HealthReport{user_id: trump_id})
trump_prescription = Repo.insert!(%Prescription{clinic_id: jeil_clinic.id, doctor: mr_hong.id, infection: false, test: "Korean Standard COVID19 Testkit"})


trump_health_report = Repo.preload(trump_health_report, [:prescriptions])
trump_health_report_cs = Ecto.Changeset.change(trump_health_report) |> Ecto.Changeset.put_assoc(:prescriptions, [trump_prescription])

trump_health_report = Repo.update!(trump_health_report_cs)

trump_treatment = %Treatment{comment: "no remarkable"}
trump_prescription = Repo.preload(trump_prescription, [:treatments])
trump_prescription_cs = Ecto.Changeset.change(trump_prescription) |> Ecto.Changeset.put_assoc(:treatments, [trump_treatment])

trump_prescription = Repo.update!(trump_prescription_cs)
Repo.preload(trump_health_report, [prescriptions: :treatments])

