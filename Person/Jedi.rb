require File.expand_path(File.dirname(__FILE__))+"/Person.rb"

class Jedi < Person
  def initialize(name=nil) 
    if name != nil
      @name = name 
    else 
      randomize_name
    end
    
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
  
  private
  
  def randomize_name
    first_name = ['Aaron', 'Byron', 'Ceylon', 'Dervos', 'Anna', 'Syphia', 'Ergoton', 'Malvis', 'Wekkon', 'Vittas',
                    'Pleyos', 'Qequos', 'Zevra', 'Olgris', 'Prapronos', 'Kakanos']
    second_name = ['Mat', 'Zat', 'Rat', 'Wes', 'Vzyt', 'Lel', 'Sky', 'Deat', 'Wolt', 'Ravan', 'Star', 'Moon', 'Totos', 
                    'Qyuv', 'Ares', 'Taur', 'Ion']
                    
    third_name = ['walker', 'zyros', 'alva', 'orys', 'uios', 'okron', 'walker', 'killer', 'destroyer', 'willer', 'ustin',
                    'fall', 'meton', 'rygos']
                    
    @name = first_name.sample+" "+second_name.sample+third_name.sample
  end
end