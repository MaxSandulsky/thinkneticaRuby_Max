# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'prodaction_company.rb'
require_relative 'manufacturer.rb'

class Wagon
  include Manufacturer
  include InstanceCounter

  def initialize(number, manufacturer)
    self.manufacturer = manufacturer
    self.number = number

    register_instance
  end
end
