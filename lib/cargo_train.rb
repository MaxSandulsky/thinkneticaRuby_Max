# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'train.rb'

class CargoTrain < Train
  def initialize(number, prodaction_company)
    super(number, prodaction_company)
    self.wagons_type = 'CargoWagon'
  end
end
