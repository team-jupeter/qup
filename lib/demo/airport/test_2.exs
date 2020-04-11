alias Demo.Repo
alias Demo.Airport
alias Demo.Airport.{Airline, Passenger, NationalAirport}
alias Demo.Accounts.User

user1 = %User{name: "Jupeter"}
user2 = %User{name: "Superman"}
user3 = %User{name: "Batman"}
user4 = %User{name: "Xman"}
user5 = %User{name: "Joker"}

user_1 = Repo.insert!(user1)
user_2 = Repo.insert!(user2)
user_3 = Repo.insert!(user3)
user_4 = Repo.insert!(user4)
user_5 = Repo.insert!(user5)

passenger1 = Ecto.build_assoc(user_1, :passengers, %{name: "Mr. Jupeter"})
passenger2 = Ecto.build_assoc(user_2, :passengers, %{name: "Mr. Superman"})
passenger3 = Ecto.build_assoc(user_3, :passengers, %{name: "Mr. Batman"})
passenger4 = Ecto.build_assoc(user_4, :passengers, %{name: "Mr. Xman"})
passenger5 = Ecto.build_assoc(user_5, :passengers, %{name: "Mr. Joker"})
passenger_1 = 
passenger_2
passenger_3
passenger_4
passenger_1

airport1 = %Airport{name: "Incheon Airport", tagline: "Something about airports ..."}
airport2 = %Airport{name: "Jeju Airport", tagline: "Something about airports ..."}
airport3 = %Airport{name: "New York Airport", tagline: "Something about airports ..."}
airport4 = %Airport{name: "Tokyo Airport", tagline: "Something about airports ..."}

airport_1 = Repo.insert!(airport1)
airport_2 = Repo.insert!(airport2)
airport_3 = Repo.insert!(airport3)
airport_4 = Repo.insert!(airport4)

passenger1 = Ecto.build_assoc(airport1, :passengers, %{name: "Mr. Jupeter"})
# passenger1 = Ecto.build_assoc(airport1, :passengers, user_1)
passenger2 = Ecto.build_assoc(airport2, :passengers, user_2)
passenger3 = Ecto.build_assoc(airport3, :passengers, user_3)
passenger4 = Ecto.build_assoc(airport4, :passengers, user_4})
passenger5 = Ecto.build_assoc(airport1, :passengers, user_1})

Repo.insert!(passenger1)
Repo.insert!(passenger2)
Repo.insert!(passenger3)
Repo.insert!(passenger4)
Repo.insert!(passenger5)

korea_airports_corporation = %NationalAirport{name: "Korea Airport Corporation"}
us_airports_corporation = %NationalAirport{name: "US Airport Corporation"}
japan_airports_corporation = %NationalAirport{name: "Japan Airport Corporation"}

Repo.insert!(national_airports_1)
Repo.insert!(national_airports_2)
Repo.insert!(national_airports_3)

korea_airports_corporation = Ecto.build_assoc(airport_1, :national_airports, korea_airports_corporation)
korea_airports_corporation = Ecto.build_assoc(airport_2, :national_airports, %{name: "Korea Airport Corporation"})
us_airports_corporation = Ecto.build_assoc(airport_3, :national_airports, us_airports_corporation)
japan_airports_corporation = Ecto.build_assoc(airport_4, :national_airports, japan_airports_corporation)

Repo.insert!(korea_airports_corporation)
Repo.insert!(us_airports_corporation)
Repo.insert!(japan_airports_corporation)






airline1 = %Airline{name: "Asiana"}
airline2 = %Airline{name: "KAL"}
airline2 = %Airline{name: "JAL"}

airline_1 = Repo.insert!(airline1)
airline_2 = Repo.insert!(airline2)
airline_3 = Repo.insert!(airline3)

airport_1 = Repo.preload(airport_1, [:national_airports, :passengers, :airlines])
airport_2 = Repo.preload(airport_2, [:national_airports, :passengers, :airlines])
airport_3 = Repo.preload(airport_3, [:national_airports, :passengers, :airlines])

airport_changeset_1 = Ecto.Changeset.change(airport_1)
airport_changeset_2 = Ecto.Changeset.change(airport_2)
airport_changeset_3 = Ecto.Changeset.change(airport_3)

airport_users_changeset_1 = airport_changeset_1 |> Ecto.Changeset.put_assoc(:users, [user])
airport_users_changeset_2 = airport_changeset_2 |> Ecto.Changeset.put_assoc(:users, [user])
airport_users_changeset_3 = airport_changeset_3 |> Ecto.Changeset.put_assoc(:users, [user])



Repo.update!(airport_users_changeset_1)
Repo.update!(airport_users_changeset_2)
Repo.update!(airport_users_changeset_3)

# changeset = airport_changeset |> Ecto.Changeset.put_assoc(:users, [%{name: "Gary"}])
# Repo.update!(changeset)
