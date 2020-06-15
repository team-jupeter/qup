import Ecto.Query
import Ecto.Changeset
alias Demo.Repo

# ? init nations
alias Demo.Nations.Nation

korea = Nation.changeset(%Nation{}, %{name: "South Korea"}) |> Repo.insert!()

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
  StateSupul.changeset(%StateSupul{}, %{name: "Jejudo State Supul", supul_code: 0x01434500}) \
  |> Repo.insert!()

hankyung_supul =
  Supul.changeset(%Supul{}, %{name: "Hankyung Supul", supul_code: 0x01434500}) \
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
  User.changeset(%User{}, %{name: "Gong Ja", email: "gong_ja@82345.kr"}) \
  |> Repo.insert!()

mr_meng =
  User.changeset(%User{}, %{name: "Meng Ja", email: "meng_ja@82345.kr", certificates: ["Lawyer"]}) \
  |> Repo.insert!()


#? hard coded lawyer certificate
alias Demo.Certificates.Certificate
Repo.preload(mr_meng, [:certificates]) |> Ecto.Changeset.change() \
  |> Ecto.Changeset.put_assoc(:certificates, [%Certificate{title: "Lawyer"}]) \
  |> Repo.update!

Repo.preload(mr_gong, [:certificates]) |> Ecto.Changeset.change() \
  |> Ecto.Changeset.put_assoc(:certificates, [%Certificate{title: "Lawyer"}]) \
  |> Repo.update!


'''
STEP ONE(1)
Suggestion
'''
#? 이 몽룡 등이 법률의 신설 또는 기존 법률의 수정제안을 게시판에 게시

alias Demo.Votes.Law
  law = Law.changeset(%Law{}, %{
    article: 1,
    clause: 2,
    current_hash:  "315234dfadsadfaff81da3d463ed", #? :crypto.hash(:sha256, previous_contents)
    suggested_update: "이 법은 국민 건강에 위해(危害)가 되는 감염병의 발생과 ...",
  }) |> Repo.insert!
  
  
'''
STEP TWO(2)
INITIATIVE
'''
voting_rule = [ #? 헌법, 법률, 규칙, 규정
  %{type: "constitution", number_of_initiatives: 1_000_000},
  %{type: "law", number_of_initiatives: 100_000},
  %{type: "ordinance", number_of_initiatives: 10_000},
  %{type: "rule", number_of_initiatives: 1_000},
]

#? Lee Mong Ryong etc. publicize their suggestion and get supporters equal to or more than the necessary supporters described in voting rule.
alias Demo.Votes.Initiative
initiative = Initiative.changeset(%Initiative{}, %{
  type: "Law", #? constitution, ordinance, rule, law
  initiators: [mr_lee.id, ms_sung.id],
  lawyers: [mr_meng.id, mr_gong.id],
  layer_review: "본 제안은 헌법 및 이전 법률과 상치하지 않고....의 효과가 예상되며...",
  law_id: law.id,
  supports: 23451, #? number of supports from bulletin board.
  # supporters: [mr_hong] #? pretend more than 10_000 supporters.
}) |> Repo.insert!



'''
STEP THREE(3)
PREPARE SURVEY

#? WRITE CONTEXT MODULE
case initiative.type == voting_rule.type 
  && initiative.num_of_initiators >= voting_rule.num_of_initiators do
end
'''


alias Demo.Votes.SurveyEmbed
survey = SurveyEmbed.changeset(%SurveyEmbed{}, %{
  title: "Update Criminal Law article 1, clause 1",
  respondent: mr_hong.id,
  summary: "형사소송법 조항 1항 1조의 이전 문구 ...을 새로운 문구 ...로 바꾸는 제안으로, 그 취지는 ...",
  discussion_site: "http://example.com/discussion/article1"
}) 



'''
STEP FOUR(4)
SEND SURVEY 
(1) SELECT TWO SAMPLE GROUPS FROM POPULATIONS(의원, 대의원, 권리당원, 일반 시민)
(2) SEND SURVEYS TO THE SAMPLE GROUPS
(3) RECEIVE SURVEYS FROM RESPONDENTS
'''
#? For example, mr_hong belongs to the sample group, and a respondent.

#? First, mr_hong makes a payload with his signed survey, and sends it to hankyung_supul's mulet.
import Poison

# serialize the JSON
msg_serialized = Poison.encode!(survey)

# generate time-stamp
ts = DateTime.utc_now |> DateTime.to_unix

# add a time-stamp
ts_msg_serialized = "#{ts}|#{msg_serialized}"


hong_rsa_priv_key = ExPublicKey.load!("./keys/hong_private_key.pem")
hong_rsa_pub_key = ExPublicKey.load!("./keys/hong_public_key.pem")


# generate a secure hash using SHA256 and sign the message with the private key
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, hong_rsa_priv_key)

# combine payload
payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64 signature}"



#? Second, the hankyung_mulet verifies and unserialize the payload from mr_hong. 

alias Demo.Mulets.Mulet
hankyung_mulet = Ecto.build_assoc(hankyung_supul, :mulet, %{current_hash: hankyung_supul.id}) 

# pretend transmit the message...
# pretend receive the message...

# break up the payload
parts = String.split(payload, "|")

#? reject the payload if the timestamp is newer than the arriving time to mulet. 
recv_ts = Enum.fetch!(parts, 0)


# pretend ensure the time-stamp is not too old (or from the future)...
#? it should probably no more than 5 minutes old, and no more than 15 minutes in the future

# verify the signature
recv_msg_serialized = Enum.fetch!(parts, 1)
{:ok, recv_sig} = Enum.fetch!(parts, 2) |> Base.url_decode64

{:ok, sig_valid} = ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig, hong_rsa_pub_key)
# assert(sig_valid)

recv_msg_unserialized = Poison.Parser.parse!(recv_msg_serialized, %{})
# assert(msg == recv_msg_unserialized)


#? Third, the mulet of korea_supul openhashes the message. 
alias Demo.Mulets.Mulet
korea_mulet = Ecto.build_assoc(korea_supul, :mulet, %{current_hash: korea_supul.id}) 

survey_hash = 
    :crypto.hash(:sha256, recv_msg_serialized) \
    |> Base.encode16() \
    |> String.downcase() 

korea_mulet = Mulet.changeset(korea_mulet, %{incoming_hash: survey_hash})



'''
STEP FIVE(5)
COLLECT SURVEY RESULTS
'''
#? There are two rounds. If the results of the two are significantly different, do the survey process again from the start.
alias Demo.Votes.Vote
vote = Vote.changeset(%Vote{}, %{
    area: "South Korea",
    type: "Law", 
    law_id: law.id, 
    }) |> Repo.insert!

alias Demo.Votes.RoundEmbed
round_1 = RoundEmbed.changeset(%RoundEmbed{}, %{
    num_of_round: 1, 
    vote_on: "2020-04-13",
    agreed_pecentage: 78,
    num_of_agrees: 56654, 
    num_of_disagrees: 9254, 
    sample_percentage: 5, 
    confidence_interval: 97, 
    sample_error: 5, 
    per_area: %{서울: 14254, 경기: 11433, 인천: 45345},
    # per_age: %{10s: 14254, 20s: 11433, 30s: 45345},
    per_sex: %{male: 25435, female: 24535}, 
    per_economic_class: %{higher: 23533, middle: 34353, lower: 34354}, #? 소득 분위 
    per_education_degree: %{college: 34254, secondary: 34543}, #? 학력 분포
    agreed_users: [ms_sung.id], #? all the user_ids who agreed.
    disagreed_users: [mr_hong.id],  #? all the user_ids who disagreed.
    per_voting_power: %{의원: 123, 대의원: 4245, 권리당원: 14442, 국민: 32443}, 
    }) 

#? pretend another sample group
round_2 = RoundEmbed.changeset(%RoundEmbed{}, %{
    num_of_round: 1, 
    vote_on: "2020-04-13",
    agreed_pecentage: 78,
    num_of_agrees: 56654, 
    num_of_disagrees: 9254, 
    sample_percentage: 5, 
    confidence_interval: 97, 
    sample_error: 5, 
    per_area: %{서울: 14254, 경기: 11433, 인천: 45345},
    # per_age: %{10s: 14254, 20s: 11433, 30s: 45345},
    per_sex: %{male: 25435, female: 24535}, 
    per_economic_class: %{higher: 23533, middle: 34353, lower: 34354}, #? 소득 분위 
    per_education_degree: %{college: 34254, secondary: 34543}, #? 학력 분포
    agreed_users: [], #? all the user_ids who agreed.
    disagreed_users: [],  #? all the user_ids who disagreed.
    per_voting_power: %{의원: 123, 대의원: 4245, 권리당원: 14442, 국민: 32443}, 
    }) 


    
'''
STEP SIX(6)
REFLECT THE SURVEY RESULT TO THE VOTE

#? WRITE CONTEXT MODULE
case round_1.agreed_pecentage ~= round_2.agreed_pecentage do
end
'''

vote = change(vote) \
  |> Ecto.Changeset.put_change(:vote_result, "PASSED") \
  |> Ecto.Changeset.put_embed(:round_embeds, [round_1, round_2]) \
  |> Repo.update!


'''
QUIZ
'''
#? Write codes to archive the vote into "Korea Supul".
#? Write codes to pay initiators double the price of lawyer fee they have paid, if the law has passed.
#? Write codes to reflect the above transaction onto the BS of related parties, initiators and the party.
#? Write codes to grand different voting powers to 의원(5), 대의원(4), 권리당원(3), 일반당원(2), 시민(1).