# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'train.rb'

class PassengerTrain < Train
  
  def wagon_connect(wagon)
    super if wagon.class == PassengerWagon
  end

end
