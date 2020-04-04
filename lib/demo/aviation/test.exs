iex -S mix
Demo.Airport.start_link()
Demo.Airport.get()

Demo.ControlTower.arrive("Asiana", 4)
Demo.ControlTower.arrive("KAL", 2)
Demo.Airport.get()
Demo.ControlTower.depart("Air_Busan", 1)
Demo.Airport.get()


# Terminal 1

$ iex --sname node1@localhost -S mix
Demo.Airport.start_link()
Demo.Airport.get()



# Terminal 2

$ iex --sname node2@localhost -S mix
Node.connect(:node1@localhost)
Demo.ControlTower.arrive("Jeju_Air", 1)


# Terminal 1
Demo.Airport.get()

