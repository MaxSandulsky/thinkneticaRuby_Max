# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'prodaction_company.rb'
require_relative 'instance_counter.rb'

class Wagon
  include ProdactionCompany
  include InstanceCounter
  
  def initialize(number, prodaction_company)
    self.prodaction_company = prodaction_company
    self.number = number
    
    register_instance
  end
end
