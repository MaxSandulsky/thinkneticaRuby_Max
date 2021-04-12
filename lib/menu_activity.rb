# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module MenuActivity
  def create_route(input_station_index)
    add_station_pool = []
    puts 'Specify route number:'
    route_index = gets.to_i
    if routes_pool[route_index].nil? && !input_station_index.nil?
      input_station_index.each { |x| add_station_pool.push(stations_pool[x]) }
      routes_pool[route_index] = Route.new(add_station_pool)
    else puts 'This number is already taken or you make an error'
    end
  end

  def create_station(title)
    stations_pool.push(Station.new(title))
  end

  def create_cargo_train
    puts 'Specify train number: '
    input_ = gets.to_i
    if trains_pool[input_].nil?
      trains_pool[input_] = PassengerTrain.new(input_)
    else puts 'This number is already taken'
    end
  end

  def create_passenger_train
    puts 'Specify train number: '
    input_ = gets.to_i
    if trains_pool[input_].nil?
      trains_pool[input_] = CargoTrain.new(input_)
    else puts 'This number is already taken'
    end
  end

  def create_cargo_wagon
    puts 'Specify wagon number: '
    input_ = gets.to_i
    if wagons_pool[input_].nil?
      wagons_pool[input_] = CargoWagon.new
    else puts 'This number is already taken'
    end
end

  def create_passenger_wagon
    puts 'Specify wagon number: '
    input_ = gets.to_i
    if wagons_pool[input_].nil?
      wagons_pool[input_] = PassengerWagon.new
    else puts 'This number is already taken'
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
    if train.next_station.nil?
      train_route_reverse(train)
    else
      puts "Train arriving to: #{train.current_station.title}, next station: #{train.next_station.title}"
    end
  end

  def train_move_backward(train)
    puts "Train leaving: #{train.current_station.title}, next station: #{train.passed_station.title}"
    train.move_backward
    if train.passed_station.nil?
      train_route_reverse(train)
    else
      puts "Train arriving to: #{train.current_station.title}, next station: #{train.passed_station.title}"
    end
  end

  def train_route_reverse(train)
    puts 'You have reach your destination, route rebuilt'
    train.route.route_reverse(train.route.stations.reverse)
    train.train_route = train.route
  end
end
