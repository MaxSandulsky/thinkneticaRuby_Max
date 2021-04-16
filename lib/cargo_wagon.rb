# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'wagon.rb'

class CargoWagon < Wagon
  def initialize(number, prodaction_company)
    super(number, prodaction_company)
    self.type = 'Cargo'
  end
end
