import Ecto.Query
import Ecto.Changeset
alias Demo.Repo

# ? init nations
alias Demo.Nations.Nation

korea = Nation.changeset(%Nation{}, %{name: "South Korea"}) |> Repo.insert!()

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
  Supul.changeset(%Supul{}, %{name: "Hankyung Supul", supul_code: 0x01434500}) \
  |> Repo.insert!()

namwon_supul =
  Supul.changeset(%Supul{}, %{name: "Namwon Supul", supul_code: 0x4354500}) \
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

mr_lee =
  User.changeset(%User{}, %{name: "Lee Mong Ryong", email: "mong@86345.kr"}) \
  |> Repo.insert!()

mr_gong =
  User.changeset(%User{}, %{name: "Gong Ja", email: "gongja@82345.kr"}) \
  |> Repo.insert!()

mr_meng =
  User.changeset(%User{}, %{name: "Meng Ja", email: "mengja@82345.kr"}) \
  |> Repo.insert!()


# ?many_to_many
# |> Ecto.Changeset.change()  \
# |> Ecto.Changeset.put_assoc(:products, [hiv_test])  \
# |> Repo.update!()


'''
INIT
SCHOOL, MENTORS, STUDENTS
'''
#? init a school in Hankyung-Myon, Jeju
alias Demo.Schools.School
abc_hankyung = School.changeset(%School{}, %{
  type: "Elementary 4th" #? kindergarten, elementary, middle, college, graduate
}) |> Repo.insert!

#? build_assoc school and its supul.
abc_hankyung = Ecto.build_assoc(hankyung_supul, :schools, abc_hankyung) 


#? init MR_GONG as a mentor, and put him into abc_hankyung school above. 
alias Demo.Schools.Mentor
mentor_gong = Mentor.changeset(%Mentor{}, %{
  name: "Gongja",
  certificates: ["E1", "M2", "C3"], #? we hard coded here, but they should be associated.
  user_id: mr_gong.id
}) |> Repo.insert!


Repo.preload(abc_hankyung, [:mentors]) \
|> Ecto.Changeset.change()  \
|> Ecto.Changeset.put_assoc(:mentors, [mentor_gong])  \
|> Repo.update!()

Repo.preload(mentor_gong, :user)

#? init mr_hong and mr_sung as  
alias Demo.Schools.Student
student_hong = Student.changeset(%Student{}, %{
  name: "홍길동",
  current_course: ["E1, M1, Code1"], #? we hard coded here, but they should be associated.
  user_id: mr_hong.id
}) |> Repo.insert!

student_sung = Student.changeset(%Student{}, %{
  name: "성춘향",
  current_course: ["E1, M2, Code3"],
  user_id: ms_sung.id
}) |> Repo.insert!

Repo.preload(student_sung, :user)




#? register sung and hong to the abc_hankyung == add ms_sung to mr_hong's current classmate, and vice versa
Repo.preload(abc_hankyung, [:students]) \
|> Ecto.Changeset.change()  \
|> Ecto.Changeset.put_assoc(:students, [student_hong, student_sung])  \
|> Repo.update!()

Repo.preload(abc_hankyung, [:students, :mentors])


student_hong = Ecto.build_assoc(abc_hankyung, :students, student_hong)
student_sung = Ecto.build_assoc(abc_hankyung, :students, student_sung)

Repo.preload(student_sung, :school)



#? TEST SCORES
#? student_hong get "B" at E1 QUIZ, and student_sung "A"
alias Demo.Schools.ScoreEmbed
hong_e1_score = ScoreEmbed.changeset(%ScoreEmbed{
  subject: "E1", test_date: ~N[2020-05-24 06:14:09], test_type: "Online QUIZ", score: "B"})

student_hong = change(student_hong) \
  |> Ecto.Changeset.put_embed(:scores, [hong_e1_score]) \
  |> Repo.update!



sung_e1_score = ScoreEmbed.changeset(%ScoreEmbed{
  subject: "E1", test_date: ~N[2020-05-24 06:14:09], test_type: "Online QUIZ", score: "A"})

student_sung = change(student_sung) |> \
  Ecto.Changeset.put_embed(:scores, [sung_e1_score]) \
  |> Repo.update!

'''
-- omitted --
ARCHIVE TRANSACTION
archive the scores in the supul.
'''

'''
-- omitted --
CODE3 CERTIFICATE
pretend ms_sung finished code3 and granted code3 certificate.
'''

'''
-- omitted --
NEW SCHOOL 
pretend ms_sung enters a new school, abc_namwon.
'''



#? LEARNING PATH
#? student_sung finished the abc_hankyung, and subscribe abc_namwon
abc_namwon = School.changeset(%School{}, %{
  type: "Middle_1st"
}) |> Repo.insert!

#? build_assoc school and its supul.
abc_namwon = Ecto.build_assoc(namwon_supul, :schools, abc_namwon) 

student_lee = Student.changeset(%Student{}, %{
  name: "이몽룡",
  current_course: ["E3, M4, Code5"],
  user_id: mr_lee.id
}) |> Repo.insert!


Repo.preload(abc_namwon, [:students]) \
|> Ecto.Changeset.change()  \
|> Ecto.Changeset.put_assoc(:students, [student_sung, student_lee])  \
|> Repo.update!()


#? update the past schools of 성 춘향 
student_sung = change(student_sung) |> \
    Ecto.Changeset.put_change(
        :past_schools, ["abc_hankyung"]) |> Repo.update!







'''

GAB
At the moment of getting GAB account, everyone is given credit rate "DDD".
Now, ms_sung has achieved a small progress in coding, what about updating her credit rate to "DDC" ?
Write code. 

'''




'''
QUIZ
'''
#? Write codes to grant certificates to mentors. For example, mentors need "E1 Certificate" to include "E1" as one of their subjects.  
#? Write codes to pay tuition fees to abc_campus and archive the transactions in supul or state_supul 
#? Write codes to associate (1) mentors and their certificates, (2) students and their courses. and (3)students and their schools.
#? Write codes to archive the scores of students into the supuls of their schools respectively.
#? Write codes to change the credit rate of sung_entity to "DDC".