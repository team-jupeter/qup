alias Demo.Repo
alias Demo.Airport
alias Demo.Airport.{Airline, Passenger, NationalAirport}
alias Demo.Accounts.User

user = %User{name: "Jupeter"}
user = Repo.insert!(user)
passenger = Ecto.build_assoc(user, :passengers, %{name: "Mr. Jupeter"})

airport = %Airport{name: "Incheon Airport", tagline: "Something about airports ..."}
airport = Repo.insert!(airport)

passenger = Ecto.build_assoc(airport, :passengers, %{name: "Mr. Jupeter"})
Repo.insert!(passenger)

korea_airports_corporation = %NationalAirport{name: "Korea Airports Corporation"}
# Repo.insert!(korea_airports_corporation)
korea_airports_corporation = Ecto.build_assoc(airport, :national_airport, %{name: "Korea Airports Corporation"})

Repo.insert!(korea_airports_corporation)

airline = %Airline{name: "Asiana"}
airline = Repo.insert!(airline)

airport = Repo.preload(airport, [:national_airport, :passengers, :airlines])
airport_changeset = Ecto.Changeset.change(airport)
airport_airlines_changeset = airport_changeset |> Ecto.Changeset.put_assoc(:airlines, [airline])
Repo.update!(airport_airlines_changeset)

changeset = airport_changeset |> Ecto.Changeset.put_assoc(:airlines, [%{name: "Asiana Airlines"}])
Repo.update!(changeset)
