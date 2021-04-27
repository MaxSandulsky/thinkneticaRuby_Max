require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Station
  include InstanceCounter
  include Validation

  attr_reader :title, :trains

  TITLE_FORMAT = /^[A-Z][a-z]+/

  def initialize(title)
    @trains = []
    @title = title

    self.class.validate(obj: title, validation: 'presence')
    self.class.validate(obj: title, regexp: TITLE_FORMAT, validation: 'format')

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
