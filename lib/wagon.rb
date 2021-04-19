# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'instance_counter.rb'
require_relative 'manufacturer.rb'
require_relative 'train_validation.rb'

class Wagon
  include Manufacturer
  include InstanceCounter
  include TrainValidation
  
  def initialize(number, manufacturer)
    self.manufacturer = manufacturer
    self.number = number

    validation!
    
    register_instance
  end
end
