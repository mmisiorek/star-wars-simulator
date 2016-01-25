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

      lightSide = rand(5000)-2500
      darkSide = rand(5000)-2500
      if (goodGuy.force+lightSide-badGuy.force-darkSide).abs > 1500
        if goodGuy.force+lightSide < badGuy.force+darkSide
          goodGuy.dead = true
          @dead.push(goodGuy)
          @goodSide.delete(goodGuy)
          
          @events.push(Event.new(goodGuy, badGuy, "dead", nil, lightSide, darkSide))
        else
          badGuy.dead = true
          @dead.push(badGuy)
          @badSide.delete(badGuy)
          
          @events.push(Event.new(goodGuy, badGuy, nil, "dead", lightSide, darkSide))
        end
      elsif (goodGuy.force+lightSide-badGuy.force-darkSide).abs > 1000
        if goodGuy.force+lightSide > badGuy.force+darkSide
          @injured.push(badGuy)
          badGuy.force = new_force_after_injure(badGuy)
          
          @events.push(Event.new(goodGuy, badGuy, nil, 'injured', lightSide, darkSide))
        else 
          @injured.push(goodGuy)
          goodGuy.force = new_force_after_injure(goodGuy)     
          
          @events.push(Event.new(goodGuy, badGuy, 'injured', nil, lightSide, darkSide))
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
  
  def new_force_after_injure(guy)
    guy.force-rand(guy.force/2)
  end
end