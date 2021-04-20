require_relative 'instance_counter.rb'

class Station
  include InstanceCounter

  attr_reader :title, :trains

  TITLE_FORMAT = /^[A-Z][a-z]+/
  
  def initialize(title)
    @trains = []
    @title = title

    validation!
    
    self.class.add_instance(self)
  end

  def arriving_train(train)
    trains << train unless trains.include?(train)
  end

  def departure_train(train)
    trains.delete(train) if trains.include?(train)
  end
  
  def process_trains(&block)
    trains.each { |train| block.call(train) }
  end
  
  private
  
  def validation!
    raise 'Station title can\'t be nil' if title.nil?
    raise 'Station title must start with a capital letter' if title !~ TITLE_FORMAT
  end
  
  def valid?
    validation!
    true
  rescue
    false
  end
end
