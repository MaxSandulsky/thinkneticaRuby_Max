# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Wagon
  
  def connect(train)
    train.wagons.push(self)
  end
  
  def disconnect(train)
    train.wagons.delete(self)
  end
  
end
