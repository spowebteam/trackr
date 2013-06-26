namespace :team do 
  desc "Create Single User"
  task create: :environment do
    @users=User.all
    @users.each do |user|
      @team=Team.new
      @team.name=user.name
      @team.user_tokens="#{user.id}"
      @team.set_single
      @team.save
    end
  end

end