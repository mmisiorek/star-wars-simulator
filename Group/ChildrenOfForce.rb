require File.expand_path(File.dirname(__FILE__))+"/Group.rb"

class ChildrenOfForce < Group
  def members
    @members
  end
  
  def to_str
    puts "Children of Force"
    @members.each do |member|
      member.to_str
    end
  end
end
