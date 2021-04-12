# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module MenuText
  def greeting_text
    puts 'Welcome to the railroad control panel!'
    puts 'Press "1" to create an object'
    puts 'Press "2" to manipulate an object'
    puts 'Press "3" to inspect/change data of an object'
    puts 'Press anything else to exit'
  end

  def creating_text
    puts 'What you want to create?'
    puts 'Press "1" to create a train'
    puts 'Press "2" to create a station'
    puts 'Press "3" to create a route'
    puts 'Press "4" to create a wagon'
    puts 'Press "0" to go back'
  end

  def manipulating_text
    puts 'What you want to do'
    puts 'Press "1" to specify a route to a train'
    puts 'Press "2" to mount/unmount a wagon from a train'
    puts 'Press "3" to move a train'
    puts 'Press "0" to go back'
  end

  def data_manipulations_text
    puts 'What data do you want to know?'
    puts 'Press "1" to inspect an object'
    puts 'Press "2" to add/remove a station from a route'
    puts 'Press "3" to delete an object'
    puts 'Press "0" to go back'
  end

  def object_inspection_text
    puts 'What you want to know?'
    puts 'Press "1" to know about trains'
    puts 'Press "2" to know about stations'
    puts 'Press "3" to know about routes'
    puts 'Press "4" to know what train contains specific wagon'
    puts 'Press "0" to go back'
  end

  def train_type_text
    puts 'What type of train do you want to create?'
    puts 'Press "1" for Cargo'
    puts 'Press "2" for Passenger'
    puts 'Press "0" to go back'
  end

  def wagon_manipulation_text
    puts 'What do you want to do with wagons?'
    puts 'Press "1" for mounting'
    puts 'Press "2" for unmounting'
    puts 'Press "0" to go back'
  end

  def wagon_type_text
    puts 'What type of wagon do you want to create?'
    puts 'Press "1" for Cargo'
    puts 'Press "2" for Passenger'
    puts 'Press "0" to go back'
  end

  def train_inspection_text
    puts 'What data do you want to know about that train?'
    puts 'Press "1" to know about stations nearby'
    puts 'Press "2" to know about connected wagons'
    puts 'Press "3" to know about the route'
    puts 'Press "0" to go back'
  end

  def station_inspection_text
    puts 'What data do you want to know about that station?'
    puts 'Press "1" to know about title'
    puts 'Press "2" to know about passenger trains on board'
    puts 'Press "3" to know about cargo trains on board'
    puts 'Press "0" to go back'
  end

  def deliting_objects_text
    puts 'What you want to delete?'
    puts 'Press "1" to delete train'
    puts 'Press "2" to delete station'
    puts 'Press "3" to delete route'
    puts 'Press "4" to delete wagon'
    puts 'Press "0" to go back'
  end

  def route_selection_text
    puts 'What route do you want to select by route number?'
    routes_pool.each_with_index do |item, index|
      puts outputs_station_title(item, index).to_s
    end
  end

  def outputs_station_title(item, index)
    print "#{index + 1}: "
    item.stations.each { |x| print "#{x.title} " }
    nil
  end

  def train_selection_text
    puts 'What train do you want to select by train number?'
    trains_pool.each_with_index do |_item, index|
      puts "#{index}: item.number"
    end
  end

  def station_selection_text
    puts 'What station do you want to select by station number?'
    puts 'Press"0" for save or anything else to discard'
    stations_pool.each_with_index { |x, index| puts "#{index + 1}: #{x.title}" }
  end

  def wagon_selection_text
    puts 'What wagon do you want select?'
    puts 'Press"0" for save or anything else to discard'
    wagons_pool.each_with_index { |x, index| puts "#{index + 1}: #{x.class}" }
  end

  def train_moving_text
    puts 'What direction do you want to move the train'
    puts 'Press "1" for moving forward'
    puts 'Press "2" for moving backward'
    puts 'Press "0" to go back'
  end

  def station_moving_text
    puts 'What you want to do with station in a route?'
    puts 'Press "1" for adding station'
    puts 'Press "2" for removing station'
    puts 'Press "0" to go back'
  end
end
