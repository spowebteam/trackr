require 'spec_helper'

describe Team do
   before do 
   		@team = Team.new(name:"OPC Team",description: "The team of all OPCs, pretty much pointless, since they are all admins, they can acceess this without teams")
   end
   subject { @team }
   it {should respond_to(:name)}
   it {should respond_to(:description)}
end
