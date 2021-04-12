# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'wagon.rb'

class CargoWagon < Wagon
  attr_reader :type
  def initialize
    super
    def_type
  end

  private

  def def_type
    @type = 'Cargo'
  end
end
