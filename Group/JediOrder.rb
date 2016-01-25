require File.expand_path(File.dirname(__FILE__))+"/Group.rb"

class JediOrder < Group 
  def initialize(jedis) 
    @jedis = jedis
    super(jedis)
    
    @masterJedi = @jedis[0]
    @jedis.each do |jedi|
      if @masterJedi.force < jedi.force
        @masterJedi = jedi
      end      
    end
    @masterJedi.isMaster = true
   
    forces = @jedis.map { |jedi| jedi.force }
    maxForces = []
    (1..10).each do |idx|
      max = forces.max
      forces.delete(max)
      maxForces.push(max)
    end
    
    @jediCouncil = []
    @jedis.each do |jedi|
      if maxForces.include? jedi.force
        @jediCouncil.push(jedi)
        jedi.isJediCouncil = true
      end
    end
  end
  
  def jedis 
    @jedis
  end
  
  def after_mission_action(mission)
    mission.dead.each do |person|
      if @jedis.include? person
        @jedis.delete(person)
        @members.delete(person)
      end
    end
  end
  
  def to_str
    str = ""
    @members.each do |jedi|
       str += jedi.to_str+"\n"
    end
    
    str
  end
end