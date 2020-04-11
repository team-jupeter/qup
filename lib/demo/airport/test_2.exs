alias Demo.Repo
alias Demo.Airport
alias Demo.Airport.{Airline, Passenger, NationalAirport, AviationBoard}
alias Demo.Accounts.User
alias Demo.Nation

user2 = %User{name: "User Superman"}
user3 = %User{name: "User Batman"}
user4 = %User{name: "User Xman"}
user5 = %User{name: "User Joker"}
user_2 = Repo.insert!(user2)
user_3 = Repo.insert!(user3)
user_4 = Repo.insert!(user4)
user_5 = Repo.insert!(user5)

passenger2 = %Passenger{name: "Passenger Superman"}
passenger3 = %Passenger{name: "Passenger Batman"}
passenger4 = %Passenger{name: "Passenger Xman"}
passenger5 = %Passenger{name: "Passenger Joker"}
passenger_2 = Ecto.build_assoc(user_2, :passenger, passenger2)
passenger_3 = Ecto.build_assoc(user_3, :passenger, passenger3)
passenger_4 = Ecto.build_assoc(user_4, :passenger, passenger4)
passenger_5 = Ecto.build_assoc(user_5, :passenger, passenger5)

airport2 = %Airport{name: "Jeju Airport", tagline: "Something about airports ..."}
airport3 = %Airport{name: "New York Airport", tagline: "US airport ..."}
airport4 = %Airport{name: "Narita Airport", tagline: "A Japanese airport ..."}
airport5 = %Airport{name: "Daxing Airport", tagline: "The biggest airport ..."}
airport_2 = Repo.insert!(airport2)
airport_3 = Repo.insert!(airport3)
airport_4 = Repo.insert!(airport4)
airport_5 = Repo.insert!(airport5)

passenger_2 = Ecto.build_assoc(airport_2, :passengers, passenger_2)
passenger_3 = Ecto.build_assoc(airport_3, :passengers, passenger_3)
passenger_4 = Ecto.build_assoc(airport_4, :passengers, passenger_4)
passenger_5 = Ecto.build_assoc(airport_5, :passengers, passenger_5)
Repo.insert!(passenger_2)
Repo.insert!(passenger_3)
Repo.insert!(passenger_4)
Repo.insert!(passenger_5)

china = %Nation{name: "China"}
japan = %Nation{name: "Japan"}
usa = %Nation{name: "United States"}
china = Repo.insert!(china)
japan = Repo.insert!(japan)
usa = Repo.insert!(usa)

china_airports_corporation = %NationalAirport{name: "China Airports Corporation"}
japan_airports_corporation = %NationalAirport{name: "Japan Airports Corporation"}
usa_airports_corporation = %NationalAirport{name: "USA Airports Corporation"}

china_airports_corporation = Ecto.build_assoc(china, :national_airport, china_airports_corporation)
china_airports_corporation = Ecto.build_assoc(airport, :national_airport, china_airports_corporation)

japan_airports_corporation = Ecto.build_assoc(japan, :national_airport, japan_airports_corporation)
japan_airports_corporation = Ecto.build_assoc(airport, :national_airport, japan_airports_corporation)

usa_airports_corporation = Ecto.build_assoc(usa, :national_airport, usa_airports_corporation)
usa_airports_corporation = Ecto.build_assoc(airport, :national_airport, usa_airports_corporation)

Repo.insert!(china_airports_corporation)
Repo.insert!(japan_airports_corporation)
Repo.insert!(usa_airports_corporation)


# many to many
airline2 = %Airline{name: "KAL"}
airline3 = %Airline{name: "JAL"}
airline4 = %Airline{name: "Dungfang airline"}
airline5 = %Airline{name: "Fedex"}

airline_2 = Repo.insert!(airline2)
airline_3 = Repo.insert!(airline3)
airline_4 = Repo.insert!(airline4)
airline_5 = Repo.insert!(airline5)

airport_2 = Repo.preload(airport_2, [:national_airport, :passengers, :airlines])
airport_3 = Repo.preload(airport_3, [:national_airport, :passengers, :airlines])
airport_4 = Repo.preload(airport_4, [:national_airport, :passengers, :airlines])
airport_5 = Repo.preload(airport_5, [:national_airport, :passengers, :airlines])


airport_changeset_2 = Ecto.Changeset.change(airport_2)
airport_changeset_3 = Ecto.Changeset.change(airport_3)
airport_changeset_4 = Ecto.Changeset.change(airport_4)
airport_changeset_5 = Ecto.Changeset.change(airport_5)

airport_airlines_changeset_2 = airport_changeset_2 |> Ecto.Changeset.put_assoc(:airlines, [airline_2, airline_3, airline_4])
airport_airlines_changeset_3 = airport_changeset_3 |> Ecto.Changeset.put_assoc(:airlines, [airline_3])
airport_airlines_changeset_4 = airport_changeset_4 |> Ecto.Changeset.put_assoc(:airlines, [airline, airline_2])
airport_airlines_changeset_5 = airport_changeset_5 |> Ecto.Changeset.put_assoc(:airlines, [airline, airline_2, airline_3, airline_4, airline_5])


Repo.update!(airport_airlines_changeset_2)
Repo.update!(airport_airlines_changeset_3)
Repo.update!(airport_airlines_changeset_4)
Repo.update!(airport_airlines_changeset_5)


