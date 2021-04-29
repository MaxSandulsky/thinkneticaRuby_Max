# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'wagon.rb'

class CargoWagon < Wagon
  def initialize(number, prodaction_company, max_space)
    self.space = []
    self.max_space = max_space
    super(number, prodaction_company)
  end
end
