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
      if maxForces.include? sith.force
        sith.rank = maxForces.index(sith.force)+1
      end      
    end
  end
  
  def after_mission_action(mission)
    mission.dead.each do |person|
      if @siths.include? person
        @siths.delete(person)
        @members.delete(person)
      end
    end
    
    classify_siths
  end
  
  def siths 
    @siths
  end
  
  def to_str
    @siths.map { |sith| sith.to_str }.join("\n")
  end
end