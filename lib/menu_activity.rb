# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module MenuActivity
  
  def create_route(input_station_index)
    add_station_pool = []
    puts "Specify route number:"
    route_index = gets.to_i
    if self.routes_pool[route_index].nil? && !input_station_index.nil?
      input_station_index.each { |x| add_station_pool.push(self.stations_pool[x])}
      self.routes_pool[route_index] = Route.new(add_station_pool)
    else puts "This number is already taken or you make an error"
    end
  end
  
  def create_station(title)
    self.stations_pool.push(Station.new(title))
  end
  
  def create_cargo_train
    puts "Specify train number: "
    input_ = gets.to_i
    if self.trains_pool[input_].nil?
      self.trains_pool[input_] = PassengerTrain.new(input_)
    else puts "This number is already taken"
    end
  end
  
  def create_passenger_train
    puts "Specify train number: "
    input_ = gets.to_i
    if self.trains_pool[input_].nil?
      self.trains_pool[input_] = CargoTrain.new(input_)
    else puts "This number is already taken"
    end
  end
  
    def create_cargo_wagon
    puts "Specify wagon number: "
    input_ = gets.to_i
    if self.wagons_pool[input_].nil?
      self.wagons_pool[input_] = CargoWagon.new
    else puts "This number is already taken"
    end
  end
  
  def create_passenger_wagon
    puts "Specify wagon number: "
    input_ = gets.to_i
    if self.wagons_pool[input_].nil?
      self.wagons_pool[input_] = PassengerWagon.new
    else puts "This number is already taken"
    end
  end
  
  def assign_route_to_train(route, train)
    train.train_route = route
  end
  
  def wagon_mount(wagon, train)
    train.wagon_connect(wagon) if wagon.type.eql?(train.type) 
  end
  
  def wagon_unmount(wagon, train)
    train.wagon_disconnect(wagon) if wagon.type.eql?(train.type) 
  end
  
  def train_move_forward(train)
    puts "Train leaving: #{train.current_station.title}, next station: #{train.next_station.title}"
    train.move_forward
    unless train.next_station.nil?
      puts "Train arriving to: #{train.current_station.title}, next station: #{train.next_station.title}"
    else 
      train_route_reverse(train)
    end
  end
  
  def train_move_backward(train)
    puts "Train leaving: #{train.current_station.title}, next station: #{train.passed_station.title}"
    train.move_backward
    unless train.passed_station.nil?
      puts "Train arriving to: #{train.current_station.title}, next station: #{train.passed_station.title}"
    else 
      train_route_reverse(train)
    end
  end
  
  def train_route_reverse(train)
    puts "You have reach your destination, route rebuilt"
    train.route.route_reverse(train.route.stations.reverse)
    train.train_route = train.route
  end
end
