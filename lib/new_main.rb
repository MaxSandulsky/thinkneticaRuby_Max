load 'station.rb'
load 'route.rb'
load 'train.rb'


some_station1 = Station.new("someTitle1")
some_station2 = Station.new("someTitle2")
some_station3 = Station.new("someTitle3")
some_station4 = Station.new("someTitle4")
another_station = Station.new("AnotherTitle")

some_train = Train.new(127055, "Cargo", 4)
another_train = Train.new(354000, "Cargo", 8)

some_train.vagons_increase

some_route = Route.new(some_station1, some_station4, some_station2, some_station3)
another_route = Route.new(some_station4, some_station2)


some_train.train_route = some_route
another_train.train_route = another_route

3.times do
some_train.move_forward
end

another_train.move_forward

2.times do
some_train.move_backward
end

puts "#{some_station2.get_sorted_list("Cargo").length}"

some_route.del_station(some_station2)
another_route.add_station(another_station)