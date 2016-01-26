require File.expand_path(File.dirname(__FILE__))+"/Group.rb"

class JediOrder < Group 
  def initialize(jedis, name: nil) 
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
    
    @orderName = name
  end
  
  def jedis 
    @jedis
  end
  
  def name
    @orderName
  end
  
  def name=(orderName)
    @orderName = orderName
  end
  
  def after_mission_action(mission)
    if mission.instance_of? JediOrderExtermination and mission.is_exterminated?
      World.jedi_orders.delete(self)
      
      mission.new_jedi_orders.each do |order|
        World.jedi_orders.push(order)
      end
      
      return
    end
    
    mission.dead.each do |person|
      if @jedis.include? person
        @jedis.delete(person)
      end
    end
    @jedis = @jedis.uniq
    @members = Array.new @jedis
    
    if @jedis.size == 0
      World.jedi_orders.delete(self)
    end
    
    choose_new_master
    choose_new_council_members
    add_new_members
  end
  
  def to_str
    str = (@orderName != nil ? @orderName+"\n" : "")
    @members.each do |jedi|
       str += jedi.to_str+"\n"
    end
    
    str
  end
  
  def remove_from_order(jedi)
    @jedis.delete(jedi)
    @members = Array.new @jedis
    
    if @masterJedi == jedi
      choose_new_master
    end
    
    if @jediCouncil.include? jedi
      choose_new_council_members
    end
  end
  
  private
  
  def add_new_members 
    if rand(10) < 8
      new_jedi = Jedi.new
      
      @jedis.push(new_jedi)
      @members.push(new_jedi)
    end
  end
  
  def find_the_strongest_from_group(jedis)
    strongest = nil
    max_force = 0
    jedis.each do |jedi|
      if strongest == nil or max_force < jedi.force
        max_force = jedi.force
        strongest = jedi
      end
    end
    
    strongest
  end
  
  def choose_new_master
    @masterJedi = find_the_strongest_from_group(@jediCouncil.select { |jedi| not jedi.dead })
    
    @masterJedi.isMaster = true
  end
  
  def choose_new_council_members
    members = @jediCouncil.select { |jedi| not jedi.dead }
    non_members = @jedis.select { |jedi| not @jediCouncil.include?(jedi) }
    
    if members.size < 10 
      (1..(10-members.size)).each do |idx| 
        break if non_members.size == 0        
        jedi = find_the_strongest_from_group(non_members)
        non_members.delete(jedi)
        members.push(jedi)
        
        jedi.isJediCouncil = true
      end
    end
    
    @jediCouncil = members
  end
end