alias Demo.Repo
alias Demo.Airports
alias Demo.Airports.{Airport, Airline, Passenger, NationalAirport}
alias Demo.Accounts.User
alias Demo.Nation

user = %User{name: "User Jupeter"}
user = Repo.insert!(user)

passenger = %Passenger{name: "Passenger Jupeter"}
passenger = Ecto.build_assoc(user, :passenger, passenger)

airport = %Airport{name: "Incheon Airport", tagline: "Something about airports ..."}
airport = Repo.insert!(airport)

passenger = Ecto.build_assoc(airport, :passengers, passenger)
Repo.insert!(passenger)



korea = %Nation{name: "South Korea"}
korea = Repo.insert!(korea)

korea_airports_corporation = %NationalAirport{name: "Korea Airports Corporation"}

korea_airports_corporation = Ecto.build_assoc(korea, :national_airport, korea_airports_corporation)
korea_airports_corporation = Ecto.build_assoc(airport, :national_airport, korea_airports_corporation)
Repo.insert!(korea_airports_corporation)


airline = %Airline{name: "Asiana"}
airline = Repo.insert!(airline)

airport = Repo.preload(airport, [:national_airport, :passengers, :airlines])
airport_changeset = Ecto.Changeset.change(airport)
airport_airlines_changeset = airport_changeset |> Ecto.Changeset.put_assoc(:airlines, [airline])
Repo.update!(airport_airlines_changeset)





changeset = airport_changeset |> Ecto.Changeset.put_assoc(:airlines, [%{name: "Asiana Airlines"}])
Repo.update!(changeset)

# ## Query
# Repo.get(Airport, 1)
# Repo.get_by(Airport, name: "Incheon Airport")
# Repo.get_by(Airport, tagline: "Something about airports ...")

# import Ecto.Query
# query = from(Airport)
# Repo.all(query)
