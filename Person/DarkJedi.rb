require File.expand_path(File.dirname(__FILE__))+"/Person.rb"

class DarkJedi
  def initialize(jedi)
    @jedi = jedi
  end
  
  def jedi 
    return @jedi
  end
end