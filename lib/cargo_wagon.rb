# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'wagon.rb'

class CargoWagon < Wagon
  def initialize(number, prodaction_company, max_space)
    super(number, prodaction_company)
    self.type = 'Cargo'
    self.space = 0
    self.max_space = max_space
  end
end
