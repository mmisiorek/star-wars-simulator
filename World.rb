require "./Group/JediOrder.rb"
require "./Group/SithOrder.rb"
require "./Group/ChildrenOfForce.rb"
require "./Mission/Event.rb"
require "./Mission/JediEscapeFromOrderEvent.rb"
require "./Mission/KillRemainingSithsMission.rb"
require "./Mission/Mission.rb"
require "./Mission/JediOrderExtermination.rb"
require "./Person/Jedi.rb"
require "./Person/Sith.rb"

class World
  def self.generate_jedi_order 
    jedis = []
    (1..20).each do |idx|
      jedis.push(Jedi.new)
    end
    
    JediOrder.new(jedis)
  end
  
  def self.generate_sith_order
    siths = []
    (1..20).each do |idx| 
      siths.push(Sith.new)
    end
    
    SithOrder.new(siths)
  end
  
  def self.jedi_orders
    @@jediOrders
  end
  
  def self.sith_orders
    [@@sithOrder]
  end
  
  def self.children_of_force_groups
    @@childrenOfForceGroups
  end
  
  def self.play
    @@jediOrders = [self.generate_jedi_order]
    @@sithOrder = self.generate_sith_order
    @@childrenOfForceGroups = []
    
    puts @@jediOrders[0].to_str
    puts @@sithOrder.to_str
    
    counter = 0 
    loop do 
      
      puts "Choose what to do: "
      char = ''
      loop do 
        char = STDIN.getc
        break if char != "\n"
      end
      
      if char == 'n'
        jedi_order = @@jediOrders.sample
        counter += 1
        
        executed_missions = []
        Mission.all_registered_mission_types.each do |missionKlass|
          if missionKlass.is_possible?(jedi_order, @@sithOrder) and
                rand(100) < missionKlass.existance_probability
              
            new_mission = nil
            if missionKlass == JediOrderExtermination
              new_mission = JediOrderExtermination.new(jedi_order, @@sithOrder)
            end 
            
            new_mission.play
            
            puts new_mission.to_str
            
            if new_mission != nil
              executed_missions.push(new_mission)
            end
          end
        end
        
        if executed_missions.size == 0
          mission = Mission.new(jedi_order.mission_group, @@sithOrder.mission_group)
          mission.play
          puts mission.to_str
          
          executed_missions.push(mission)
        end
        
        
        executed_missions.each do |mission|
          jedi_order.after_mission_action mission
          @@sithOrder.after_mission_action mission
        end
        
      elsif char == 'j'
        if @@jediOrders.size > 1
          loop do 
            @@jediOrders.each_with_index do |jediOrder, idx|
              puts (idx+1).to_s+") "+(jediOrder.name != nil ? jediOrder.name : "Default Jedi Order")
              puts jediOrder.name
            end
            
            char2 = ""
            loop do 
              char2 = STDIN.getc
              break if char2 != "\n"
            end
            
            if char2.to_i != 0 and @@jediOrders.size >= char2.to_i
              puts @@jediOrders[(char2.to_i-1)].to_str
              break
            end
          end
        elsif @@jediOrders.size == 1
          puts @@jediOrders[0].to_str
        else 
          puts "No Jedi Order exists"
        end 
      elsif char == 's'
        puts @@sithOrder.to_str
      end
      
      
    end
  end
end