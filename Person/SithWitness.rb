require File.expand_path(File.dirname(__FILE__))+"/Person.rb"

class SithWitness
  def initialize(name) 
    @name = name
  end
  
  def self.createFromJedi(jedi)
    
  end
  
  def name
    return @name
  end
end