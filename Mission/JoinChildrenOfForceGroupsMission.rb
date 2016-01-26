require File.expand_path(File.dirname(__FILE__))+'/Mission.rb'

class JoinChildrenOfForceGroupsMission < Mission
  def initialize(childrenOfForceGroup, sithOrder)
    super(childrenOfForceGroup.members, sithOrder.siths)
    
    @groupToJoin = nil
    @childrenOfForceGroup = childrenOfForceGroup
  end
  
  def play
    if rand(100) < 60
      loop do 
        @groupToJoin = World.children_of_force_groups.sample
        break if @groupToJoin != @childrenOfForceGroup
      end
    end
    
    super()
  end
  
  def group_to_join
    @groupToJoin
  end
  
  def to_str
    super()
    
    if @groupToJoin != nil
      puts "Children of the force joined: \n"
      @groupToJoin.members.each do |jedi|
        puts jedi.to_str
      end
      
      @childrenOfForceGroup.members.each do |jedi|
        puts jedi.to_str
      end
    end 
  end
  
  def self.is_possible?(goodSide, badSide)
    World.children_of_force_groups.size > 1
  end
  
  def self.existance_probability
    20
  end
end
