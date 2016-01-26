class Mission 
  def initialize(goodSide, badSide)
    @goodSide = goodSide
    @badSide = badSide
    @dead = []
    @injured = []
    @events = [] 
  end
  
  def play
    (1..rand(10)+1).each do |idx|
      break if @goodSide.size == 0
      break if @badSide.size == 0
      
      goodGuy = @goodSide[rand(@goodSide.size)]
      badGuy = @badSide[rand(@badSide.size)]

      lightSide, darkSide = power_of_force()
      if (goodGuy.force+lightSide-badGuy.force-darkSide).abs > 1500
        if goodGuy.force+lightSide < badGuy.force+darkSide
          @events.push(Event.new(goodGuy, badGuy, "dead", nil, lightSide, darkSide))

          goodGuy.dead = true
          @dead.push(goodGuy)
          @goodSide.delete(goodGuy)
          add_exp(badGuy, goodGuy)
        else
          @events.push(Event.new(goodGuy, badGuy, nil, "dead", lightSide, darkSide))

          badGuy.dead = true
          @dead.push(badGuy)
          @badSide.delete(badGuy)
          add_exp(goodGuy, badGuy)
        end
      elsif (goodGuy.force+lightSide-badGuy.force-darkSide).abs > 1000
        if goodGuy.force+lightSide > badGuy.force+darkSide
          @events.push(Event.new(goodGuy, badGuy, nil, 'injured', lightSide, darkSide))

          @injured.push(badGuy)
          badGuy.force = new_force_after_injure(badGuy)
          add_exp(goodGuy, badGuy)
        else 
          @events.push(Event.new(goodGuy, badGuy, 'injured', nil, lightSide, darkSide))

          @injured.push(goodGuy)
          goodGuy.force = new_force_after_injure(goodGuy)     
          add_exp(badGuy, goodGuy)
        end
      else 
        @events.push(Event.new(goodGuy, badGuy, nil, nil, lightSide, darkSide))
      end
      
    end
  end
  
  def dead
    @dead
  end
  
  def injured 
    @injured
  end
  
  def to_str
    @events.map { |event| event.to_str }.join("\n")
  end
  
  def self.all_registered_mission_types
    ObjectSpace.each_object(Class).select { |c| c < self }
  end
  
  def self.is_possible?(goodSide, badSide)
    
  end
  
  def self.existance_probability
    
  end
  
  protected 
  
  def new_force_after_injure(guy)
    guy.force-rand(guy.force/2)
  end
  
  def add_exp(winner, looser)
    if winner.force > looser.force 
      winner.force += (looser.force > 10000 ? rand(300) : rand(150))
    else 
      winner.force += rand((looser.force-winner.force)/2)
    end
  end
  
  def power_of_force
    [rand(10000)-5000, rand(10000)-5000]
  end
end