load 'station.rb'
load 'route.rb'
load 'train.rb'


somestation1 = Station.new("someTitle1")
somestation2 = Station.new("someTitle2")
somestation3 = Station.new("someTitle3")
somestation4 = Station.new("someTitle4")

sometrain = Train.new(127055, "Cargo", 4)
anothertrain = Train.new(354000, "Cargo", 8)
sometrain.vagonchange("increase")

someroute = Route.new(somestation1, somestation2, somestation3, somestation4)
anotherroute = Route.new(somestation4, somestation2)

anotherroute.stations.each { |n|  puts "#{n.title}"}

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


sometrain.stationinfo
