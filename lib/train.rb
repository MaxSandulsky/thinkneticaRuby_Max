class Train
  attr_reader :speed
  attr_reader :vagons
  attr_reader :number
  attr_reader :type
  def initialize(number, type, vagons)
    @number, @type, @vagons, @trainroutepassed = number, type, vagons, []
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
    @trainroute.first.arrivingtrain(self)
  end
  
  def stationinfo
    if @trainroutepassed.length != 0
    puts "last st: #{@trainroutepassed.last.title}"
    end
    puts "Current st: #{@trainroute.first.title}"
    if @trainroute.length != 1
    puts "Next st: #{@trainroute[1].title}"
    end
  end
  
  def move(direction)
    if @trainroute.length != 1 && direction == "forward"
      @trainroute.first.departuretrain(self)
      @trainroutepassed.push(@trainroute.first)
      @trainroute.shift
      @trainroute.first.arrivingtrain(self)
    elsif @trainroutepassed.length != 0 && direction == "backward"
      @trainroute.first.departuretrain(self)
      @trainroute.unshift(@trainroutepassed.last)
      @trainroutepassed.pop
      @trainroute.first.arrivingtrain(self)
    else
      puts "Oops! Wrong direction!"
    end
  end
  
end