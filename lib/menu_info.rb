# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module MenuInfo
      
  def station_selection
    station_selection_text
    self.stations_pool[gets.to_i - 1]
  end
  
  def route_selection
    route_selection_text
    self.routes_pool[gets.to_i - 1]
  end
  
  def train_selection
    train_selection_text
    self.trains_pool[gets.to_i]
  end
  
  def wagon_selection
    wagon_selection_text
    self.wagons_pool[gets.to_i - 1]
  end
  
  def train_nearby_stations_info(train)
    unless train.current_station_index.nil?
      puts "current station: #{train.current_station.title}"
      puts "Next station: #{train.next_station.title}"
      puts "Passed station: #{train.passed_station.title}"
    end
  end
  
  def train_wagons_info(train)
    train.wagons.each { |x| puts "Connected wagon number: #{self.wagons_pool.index(x)} #{self.wagons_pool[self.wagons_pool.index(x)].type}" }
  end
  
  def train_route_info(train)
    unless train.current_station_index.nil?
      puts "Route: #{self.routes_pool.index(train.route)} through:"
      self.routes_pool[self.routes_pool.index(train.route)].stations.each { |x|  puts "#{x.title}"}
      
    end
  end
    
  def station_title_info(station)
    puts "#{station.title}"
  end
  
  def station_passenger_train_info(station)
    puts "Number of passenger trains on board: #{station.get_sorted_list('Passenger')}"
  end
  
  def station_cargo_train_info(station)
    puts "Number of cargo trains on board: #{station.get_sorted_list('Cargo')}"
  end
  
  def route_info(route)
    route.stations.each { |x| puts "#{x.title}" }
  end
  
  def wagon_info(wagon)
    self.trains_pool.select do |x|
      puts "Train number: #{self.trains_pool.index(x)}" if x.wagons.include?(wagon)
    end
  end
end
