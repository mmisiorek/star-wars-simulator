require File.expand_path(File.dirname(__FILE__))+"/Mission.rb"

class KillRemainingSithsMission < Mission
  def initialize(sith, sithOrder)
    goodSide = [sith]
    badSide = Array.new(sithOrder.siths)
    
    badSide.delete(sith)
    
    @sith = sith
    @sithOrder = sithOrder
    
    super(goodSide, badSide)
  end
  
  def play
    
  end
end