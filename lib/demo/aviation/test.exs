iex -S mix
Demo.Airport.start_link()
Demo.Airport.get()

Demo.Aviation.arrive("Jeju_airport", "Asiana", 214)
Demo.Aviation.arrive("Gwangju_airport", "KAL", 114)
Demo.Airport.get()
Demo.Aviation.depart("Gwangju_airport", "Air_Busan", 114)
Demo.Airport.get()


# Terminal 1

$ iex --sname incheon_airport@localhost -S mix
Demo.Airport.start_link()
Demo.Airport.get()



# Terminal 2

$ iex --sname jeju_airport@localhost -S mix
Demo.Airport.start_link()
Demo.Airport.get()
Node.connect(:incheon_airport@localhost)

Demo.Airport.start_link()
Demo.Airport.get()
Demo.Aviation.arrive("Gwangju_airport", "KAL", 100)


# Terminal 1
Demo.ss.get()

