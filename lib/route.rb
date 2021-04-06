class Route
  attr_reader :stations
  def initialize(first, last, *intermediatestations)
    @first, @last = first, last
    @stations = intermediatestations.push(last).unshift(first)
  end
  
  def addstation(adding, possition = 1)
    @stations.insert(possition, adding)
  end
  
  def delstation(removing)
    key = @stations.detect {|e| e == removing}
    @stations.delete(key)
  end
  
  def liststationtitles
    self.stations.each { |n|  puts "#{n.title}"}
  end
end
