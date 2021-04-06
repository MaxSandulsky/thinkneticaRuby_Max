load 'station.rb'
load 'route.rb'
load 'train.rb'


somestation1 = Station.new("someTitle1")
somestation2 = Station.new("someTitle2")
somestation3 = Station.new("someTitle3")
somestation4 = Station.new("someTitle4")
anotherstation = Station.new("AnotherTitle")

sometrain = Train.new(127055, "Cargo", 4)
anothertrain = Train.new(354000, "Cargo", 8)

sometrain.vagonchange("increase")

someroute = Route.new(somestation1, somestation4, somestation2, somestation3)
anotherroute = Route.new(somestation4, somestation2)


sometrain.trainroute = someroute
anothertrain.trainroute = anotherroute

3.times do
sometrain.move("forward")
end

anothertrain.move("forward")

2.times do
sometrain.move("backward")
end

puts "#{somestation2.getsortedlist("Cargo").length}"

someroute.delstation(somestation2)
anotherroute.addstation(anotherstation)

anotherroute.liststationtitles

sometrain.stationinfo