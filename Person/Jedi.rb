require File.expand_path(File.dirname(__FILE__))+"/Person.rb"

class Jedi < Person
  def initialize(name) 
    @name = name 
    @force = 200+rand(19800)
    @isMaster = false 
    @isJediCouncil = false
    
    super()
  end
  
  def name 
    return @name
  end
  
  def force=(force)
    @force = force
  end
  
  def force 
    return @force
  end
  
  def isMaster=(is_master)
    @isMaster = is_master
  end
  
  def isMaster
    @isMaster
  end
  
  def isJediCouncil=(is_jedi_council)
    @isJediCouncil = is_jedi_council
  end
  
  def isJediCouncil
    @isJediCouncil
  end
  
  def to_str
    str = ""
    if @isMaster
      str = "Jedi Master "
    end
    
    if @isJediCouncil and not @isMaster
      str = "Jedi Council "
    end
    
    str += @name+" "+(" "*(30-str.size))+"with force "+@force.to_s
  end
end