# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module TrainValidation
  NUMBER_FORMAT = /([a-z]|\d){3}-?([a-z]|\d){2}/
  
  protected
  
  def number_validation!
    raise "Not valid number!" if number.nil?
    raise "Not valid number!" if number !~ NUMBER_FORMAT
  end
  
  def manufacturer_validation!
    raise "Manufacturer can't be nil!" if manufacturer.nil?
  end
  
  def validation!
    number_validation!
    manufacturer_validation!
  end
  
  def valid?
    validation!
    true
  rescue
    false
  end
end
