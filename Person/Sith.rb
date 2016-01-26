require File.expand_path(File.dirname(__FILE__))+"/Person.rb"

class Sith < Person
  def initialize(name: name=nil, jedi: jedi=nil) 
    if name != nil
      @name = name
    else 
      randomize_name
    end
    
    if jedi != nil
      @force = (jedi.force*1.25 >= 20000 ? (20000-(jedi.force*1.25-20000)).floor : (jedi.force*1.25).floor)
      if @force < jedi.force 
        @force = jedi.force+100
      end
      @jedi = jedi
    else
      @force = 200+rand(19800)
    end

    @rank = nil
    
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
    
    if @jedi != nil
      str += "  (was Jedi: "+@jedi.name+" with power: "+@jedi.force.to_s+")"
    end
    
    str
  end
  
  private 
  
  def randomize_name
    first_parts = ['Yyron', 'Plag', 'Disea', 'Vad', 'Tyr', 'Kol', 'Vaad', 'Oles', 'Rytus', 'Mav', 'Proos', 'Xes', 'Xen', 
                    'Prol', 'Asen', 'Zytv', 'Vall']
    second_parts = ['us', 'as', 'es', 'uis', 'eon', 'aon', 'yon', 'os', 'er', 'or', 'ar', 'op', 'et', 'at', 'aat', 'eet', 'uut', 'ut']
    
    @name = 'Darth '+first_parts.sample+second_parts.sample
    
    @name
  end
end