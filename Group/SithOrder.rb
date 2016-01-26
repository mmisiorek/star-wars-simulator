require File.expand_path(File.dirname(__FILE__))+"/Group.rb"

class SithOrder < Group
  def initialize(siths) 
    @siths = siths
    super(siths)
    
    classify_siths
  end
  
  def classify_siths
    forces = siths.map { |sith| sith.force }    
    maxForces = []
    (1..10).each do |map|
      max = forces.max
      forces.delete(max)
      maxForces.push(max)
    end
    
    siths.each do |sith|
      sith.rank = nil
      if maxForces.include? sith.force
        sith.rank = maxForces.index(sith.force)+1
      end      
    end
  end
  
  def after_mission_action(mission)
    mission.dead.each do |person|
      if @siths.include? person
        @siths.delete(person)
      end
    end
    @siths = @siths.uniq
    @members = Array.new @siths
    
    classify_siths
    add_new_members
  end
  
  def siths 
    @siths
  end
  
  def to_str
    @siths.map { |sith| sith.to_str }.join("\n")
  end
  
  private 
  
  def add_new_members
    if rand(10) < 6
      new_sith = nil
      if rand(10) < 5 
        jedi_order = World.jedi_orders.sample
        if jedi_order == nil
          return
        end
        
        jedi = jedi_order.jedis.sample
        if jedi == nil
          return
        end
        
        new_sith = Sith.new(jedi: jedi)
        
        jedi_order.remove_from_order jedi
      else
        new_sith = Sith.new
      end
      @siths.push(new_sith)
      @members.push(new_sith)
    end
  end
end