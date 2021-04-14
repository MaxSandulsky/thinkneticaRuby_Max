# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'train.rb'

class CargoTrain < Train
  def initialize(number)
    super self.type = 'Cargo'
  end
end
