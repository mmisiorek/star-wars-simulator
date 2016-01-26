require File.expand_path(File.dirname(__FILE__))+"/Event.rb"

class JediEscapeFromOrderEvent < Event 
  def initialize(jedi)
    @jedi = jedi
  end
  
  def to_str
    "## Jedi "+@jedi.name+" with power: "+@jedi.force.to_s+" created a new order\n\n"
  end
end