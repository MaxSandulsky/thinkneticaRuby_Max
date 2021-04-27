# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      name_history = (name.to_s + '_history').to_s

      define_method("#{name}=") do |value|
        history = instance_variable_get("@#{name_history}")
        history ||= []
        history << value
        instance_variable_set("@#{name_history}", history)
        instance_variable_set("@#{name}", value)
      end

      define_method(name) { instance_variable_get("@#{name}") }
      define_method(name_history) { instance_variable_get("@#{name_history}") || [nil] }
    end
  end

  def strong_attr_accessor(name: 'name', type: 'type')
    define_method(name) do
      instance_variable_get("@#{name}")
    end

    define_method("#{name}=") do |value|
      value.each do |val|
        raise "Wrong '#{val.class.superclass}' object type '#{type}'!" unless val.class.superclass.to_s == type.to_s
      end
      instance_variable_set("@#{name}", value)
    end
  end
end
