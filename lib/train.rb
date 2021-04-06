class Train
  attr_reader :speed
  attr_reader :vagons
  attr_reader :number
  attr_reader :type
  def initialize(number, type, vagons)
    @number, @type, @vagons = number, type, vagons
  end

  def vagonchange(function)
    if @speed == 0
      if function == "decrease"
      @vagons -= 1
      elsif function == "increase"
      @vagons += 1
      end
    end
  end
  
  def speedgain(velocity)
    @speed += velocity
  end
  
  def stop
    @speed = 0
  end
  
  def trainroute=(route)
    @trainroute = route.stations
    @currentstation = 0
  end
  
  def stationinfo
    if @currentstation > 0
    puts "last st: #{@trainroute[@currentstation - 1].title}"
    end
    puts "Current st: #{@trainroute[@currentstation].title}"
    if @trainroute.length != @currentstation + 1 && @trainroute.length > 0
    puts "Next st: #{@trainroute[@currentstation + 1].title}"
    end
  end
  
  def move(direction)
    if @trainroute.length != 1 && direction == "forward"
      @trainroute[@currentstation].departuretrain(self)
      @currentstation += 1
      @trainroute[@currentstation].arrivingtrain(self)
    elsif @trainroute.length != 0 && direction == "backward"
      @trainroute[@currentstation].departuretrain(self)
      @currentstation -= 1
      @trainroute[@currentstation].arrivingtrain(self)
    else
      puts "Oops! Wrong direction!"
    end
  end
  
end