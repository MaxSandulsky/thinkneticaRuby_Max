require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Station
  include InstanceCounter
  include Validation

  attr_reader :title, :trains

  validate :title, :format, TITLE_FORMAT
  validate :trains, :array_type, :PassengerTrain
  
  def initialize(title)
    @trains = []
    @title = title

    self.validate!
    self.class.add_instance(self)
  end

  def arriving_train(train)
    trains << train unless trains.include?(train)
  end

  def departure_train(train)
    trains.delete(train) if trains.include?(train)
  end

  def process_trains
    trains.each { |train| yield(train) }
  end
end
