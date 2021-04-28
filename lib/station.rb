require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Station
  include InstanceCounter
  include Validation

  attr_reader :title, :trains

  def initialize(title)
    @trains = []
    @title = title

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

  def validate
    title_validation
    trains_validation
  end

  private

  def title_validation
    self.class.validate(obj: title, val: 'presence')
    self.class.validate(obj: title, val: 'format', reg: TITLE_FORMAT)
    self.class.validate(obj: title, val: 'type', type: String)
  end

  def trains_validation
    process_trains do |train|
      self.class.validate(obj: train, val: 'presence')
      self.class.validate(obj: train.number, val: 'format', reg: NUMBER_FORMAT)
      self.class.validate(obj: train, val: 'type', type: PassengerTrain)
    end
  end
end
