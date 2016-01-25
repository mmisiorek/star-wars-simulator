class Event
  def initialize(goodGuy, badGuy, goodGuyResult, badGuyResult, lightSide, darkSide)
    @goodGuy = goodGuy
    @badGuy = badGuy
    @goodGuyResult = goodGuyResult
    @badGuyResult = badGuyResult
    @lightSide = lightSide
    @darkSide = darkSide
    
    # it can change in the time
    @goodGuyForce = @goodGuy.force
    @badGuyForce = @badGuy.force
  end
  
  def to_str
    str = "Fight between "+@goodGuy.name+" ("+@goodGuyForce.to_s+") and "+@badGuy.name+" ("+@badGuyForce.to_s+")\n"
    str += "with force of light "+@lightSide.to_s+" and darkness "+@darkSide.to_s+"\n\n"
    
    if @goodGuyResult != nil
      str += @goodGuy.name+" is "+@goodGuyResult
    end
    
    if @badGuyResult != nil
      str += @badGuy.name+" is "+@badGuyResult
    end
    
    if @badGuyResult == nil and @goodGuyResult == nil
      str += "No result of the fight"
    end
    
    str += "\n"
  end
end