class Group
  def initialize(members) 
    @members = members
  end
  
  def random_member
    @members[rand(@members.size)]
  end
  
  def mission_group
    if @members.size > 3
      group = []
      r = rand(10)
      
      groupSize = r < 5 ? 1 : (r < 8 ? 2 : 3)
      
      (1..groupSize).each do |idx|
        member = @members[rand(@members.size)]
        @members.delete(member)
        
        group.push(member)
      end
      
      @members.concat group
      group      
    else
      [@members[rand(@members.size)]]
    end
  end
end