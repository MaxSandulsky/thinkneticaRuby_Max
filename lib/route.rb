class Route
=begin
#Я понял свою ошибку, в тексте курса было сказано, что объединять надо только после выполнения задания, но Я думал, чтобы создать новый PR, надо принять старый.
И Я вносил исправления, а потом когда хотел создать новый ответ, объединял ветки) больше так не буду.
=end
  attr_reader :first, :last, :intermediate_stations
  def initialize(first, last, *intermediate_stations)
    @first, @last = first, last
    @intermediate_stations = intermediate_stations
  end
  
  def add_station(adding, possition = 1)
    @intermediate_stations.insert(possition, adding)
  end
  
  def del_station(removing)
    @intermediate_stations.delete(removing)
  end
  
  def stations
    [first, *intermediate_stations, last]
  end
end
