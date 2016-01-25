require "./Group/JediOrder.rb"
require "./Group/SithOrder.rb"
require "./Mission/Event.rb"
require "./Mission/KillRemainingSithsMission.rb"
require "./Mission/Mission.rb"
require "./Person/Jedi.rb"
require "./Person/Sith.rb"


class World
  def self.jedi_name
    first_name = ['Aaron', 'Byron', 'Ceylon', 'Dervos', 'Anna', 'Syphia', 'Ergoton', 'Malvis', 'Wekkon', 'Vittas',
                    'Pleyos', 'Qequos', 'Zevra', 'Olgris', 'Prapronos', 'Kakanos']
    second_name = ['Mat', 'Zat', 'Rat', 'Wes', 'Vzyt', 'Lel', 'Sky', 'Deat', 'Wolt', 'Ravan', 'Star', 'Moon', 'Totos', 
                    'Qyuv', 'Ares', 'Taur', 'Ion']
                    
    third_name = ['walker', 'zyros', 'alva', 'orys', 'uios', 'okron', 'walker', 'killer', 'destroyer', 'willer', 'ustin',
                    'fall', 'meton', 'rygos']
                    
    first_name[rand(first_name.size)]+" "+second_name[rand(second_name.size)]+third_name[rand(third_name.size)]
  end
  
  def self.sith_name 
    first_parts = ['Yyron', 'Plag', 'Disea', 'Vad', 'Tyr', 'Kol', 'Vaad', 'Oles', 'Rytus', 'Mav', 'Proos', 'Xes', 'Xen', 
                    'Prol', 'Asen', 'Zytv', 'Vall']
    second_parts = ['us', 'as', 'es', 'uis', 'eon', 'aon', 'yon', 'os', 'er', 'or', 'ar', 'op', 'et', 'at', 'aat', 'eet', 'uut', 'ut']
    
    'Darth '+first_parts[rand(first_parts.size)]+second_parts[rand(second_parts.size)]
  end
  
  def self.generate_jedi_order 
    jedis = []
    (1..20).each do |idx|
      jedis.push(Jedi.new(self.jedi_name))
    end
    
    JediOrder.new(jedis)
  end
  
  def self.generate_sith_order
    siths = []
    (1..20).each do |idx| 
      siths.push(Sith.new(self.sith_name))
    end
    
    SithOrder.new(siths)
  end
  
  def self.play
    @@jediOrder = self.generate_jedi_order
    @@sithOrder = self.generate_sith_order
    
    puts @@jediOrder.to_str
    puts @@sithOrder.to_str
    
    counter = 0 
    loop do 
      
      puts "Choose what to do: "
      char = STDIN.getc
      
      if char == 'n'
        counter += 1
        mission = Mission.new(@@jediOrder.mission_group, @@sithOrder.mission_group)
        mission.play
        puts mission.to_str
        
        @@jediOrder.after_mission_action mission
        @@sithOrder.after_mission_action mission
  
      elsif char == 'j'
        puts @@jediOrder.to_str
      elsif char == 's'
        puts @@sithOrder.to_str
      end
      
      
    end
  end
end