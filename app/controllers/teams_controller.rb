class TeamsController < ApplicationController
  before_filter :admin_user
  def new
    @user=current_user
    @team=Team.new
  end

  def create
    @user = current_user
    @team = Team.new (params[:team])
    if @team.save
      flash[:success] = "Team #{@team.name} Created"
      redirect_to teams_path
    else
      flash[:error] = "Saving failed"
      redirect_to request.referer
    end
  end

  def index
    @teams=Team.all
  end

  def show
    @user=current_user
    @team=Team.find(params[:id])
  end

  def edit
  end

  def destroy
  end

  private
    def admin_user
     unless current_user.admin?
       flash[:error] = "Access Denied"
       redirect_to request.referer
     end
    end
end
