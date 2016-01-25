require File.expand_path(File.dirname(__FILE__))+"/Person.rb"

class Sith < Person
  def initialize(name) 
    @name = name
    @force = 200+rand(19800)
    @rank = nil
    
    super()
  end
  
  def self.createFromJedi(jedi) 
    
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
  
  def rank=(rank)
    @rank = rank
  end
  
  def rank
    @rank
  end
  
  def to_str
    str = ""
    if @rank != nil 
      str += "Lord #"+self.rank.to_s+" " 
    end
    
    str += @name+" "+(" "*(30-str.size))+"with force "+@force.to_s
  end
end