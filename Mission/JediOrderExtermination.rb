require File.expand_path(File.dirname(__FILE__))+"/Mission.rb"

class JediOrderExtermination < Mission
  def initialize(jediOrder, sithOrder)
    super(Array.new(jediOrder.jedis), Array.new(sithOrder.siths))
    
    @isExterminated = false
    @newJediOrders = []
  end
  
  def play
    loop do 
      break if @goodSide.size == 0 or @badSide.size == 0
      break if @badSide.size <= 5 and @goodSide.size >= 8
      
      jedi = @goodSide.sample
      sith = @badSide.sample
      
      light_side_power, dark_side_power = power_of_force()
      if (jedi.force+light_side_power-sith.force-dark_side_power).abs > 1500
        if jedi.force+light_side_power > sith.force+dark_side_power
          @events.push(Event.new(jedi, sith, nil, "dead", light_side_power, dark_side_power))
          
          sith.dead = true
          @dead.push(sith)
          @badSide.delete(sith)
          
          add_exp(jedi, sith)
        else
          @events.push(Event.new(jedi, sith, "dead", nil, light_side_power, dark_side_power))
          
          jedi.dead = true
          @dead.push(jedi)
          @goodSide.delete(jedi)
          
          add_exp(sith, jedi)
        end
      else
        if @goodSide.size <= 7
          @events.push(Event.new(jedi, sith, nil, nil, light_side_power, dark_side_power))
          @events.push(JediEscapeFromOrderEvent.new(jedi))
          
          new_order = JediOrder.new([jedi], name: "Jedi Order of "+jedi.name)
          @newJediOrders.push(new_order)
          @goodSide.delete(jedi)
        else
          @events.push(Event.new(jedi, sith, nil, nil, light_side_power, dark_side_power))
        end
      end
    end
    
    if @newJediOrders.size > 0 and @goodSide.size > 0
      @newJediOrders.push(JediOrder.new(@goodSide))
      @isExterminated = true
    end
    
    if @goodSide.size == 0
      @isExterminated = true
    end
  end
  
  def is_exterminated?
    @isExterminated
  end
  
  def new_jedi_orders
    @newJediOrders
  end
  
  def self.is_possible?(goodSide, badSide)
    goodSide.jedis.size < badSide.siths.size
  end
  
  def self.existance_probability
    20
  end
end

