iex -S mix
alias Demo.Aviation
alias Demo.Aviation.Airport


Airport.start_link()
Airport.get()

Aviation.arrive("Jeju_airport", "Asiana", 214)
Aviation.arrive("Gwangju_airport", "KAL", 114)
Airport.get()
Aviation.depart("Gwangju_airport", "Air_Busan", 114)
Airport.get()


# Terminal 1

$ iex --sname incheon_airport@localhost -S mix
Airport.start_link()
Airport.get()



# Terminal 2

$ iex --sname jeju_airport@localhost -S mix
Airport.start_link()
Airport.get()
Node.connect(:incheon_airport@localhost)

Airport.start_link()
Airport.get()
Aviation.arrive("Gwangju_airport", "KAL", 100)


# Terminal 1
Demo.ss.get()

