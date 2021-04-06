load 'station.rb'
load 'route.rb'
load 'train.rb'


someStation1 = Station.new("someTitle1")
someStation2 = Station.new("someTitle2")
someStation3 = Station.new("someTitle3")
someStation4 = Station.new("someTitle4")

someTrain = Train.new(127055, "Cargo", 4)
someTrain.vagonchange("increase")

someRoute = Route.new(someStation1, someStation2, someStation3, someStation4)

someTrain.trainroute = someRoute

3.times do
someTrain.move("forward")
end

2.times do
someTrain.move("backward")
end

puts "#{someStation2.getsortedlist("Cargo")}"

#someTrain.stationinfo
