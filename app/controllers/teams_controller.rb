class TeamsController < ApplicationController
  before_filter :admin_user
  # autocomplete :user, :name
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
      redirect_to goback
    end
  end

  def index
    @user = current_user
    @teams=Team.all(:include => :users)
    respond_to do |format|
      format.html
      format.json {render json: @teams}
    end
  end

  def show
    @users=User.select("name,identifier,id").where(level: Global.level[:superadmin] .. Global.level[:disabled])
    # @user_name=@users.pluck(:name)
    # @user_identifier=@users.pluck(:identifier)
    # @user_ids=@users.pluck(:id)
    # @items=@user_name.zip(@user_identifier)
    # @items=@items.zip(@user_ids)
    @user=current_user
    @team=Team.find(params[:id])
  end

  def edit
    @user=current_user
    @team=Team.find(params[:id])
  end

  def update
    @user=current_user
    @team=Team.find(params[:id])
    if @team.update_attributes(params[:team])
      flash[:success]="Team details updated"
      redirect_to @team
    else
      render 'edit'
    end
  end

  def destroy
    Team.find(params[:id]).destroy
    flash[:success]="Team destroyed"
    redirect_to teams_path
  end

  private
    def admin_user
     unless current_user.admin?
       flash[:error] = "Access Denied"
       redirect_to goback
     end
    end
end
