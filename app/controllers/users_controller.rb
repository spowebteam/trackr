class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index,:show,:edit,:update,:destroy]
  before_filter :correct_user, only: [:edit,:update]
  before_filter :admin_user, only: [:destroy,:editlevel]
  def index
    @counterstart=1;
    if current_user.superadmin?
      @users=User.paginate(page: params[:page])
    else
      @users=User.where(level: Global.level[:superadmin] .. Global.level[:disabled]).paginate(page: params[:page])
    end
    @pagenum= params[:page]? params[:page].to_i : 1
    @counterstart=(User.per_page*(@pagenum-1))+1  
  end
  def show
  	@user=User.find(params[:id])
  end

  def new
  	@user= User.new
  end

  def create
  	@user = User.new (params[:user])
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
      unless signed_in?
  		  redirect_to @user
      end
  	else
  		render 'new'
  	end
  end

  def editlevel
    @user=User.find(params[:id])
    level=params[:level]
    if level
      @user.level = level
    else
      @user.level = 127
    end
    @user.save
    redirect_to users_path
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(params[:user])
        flash[:success]="Profile updated"
        sign_in @user
        redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success]="User Removed"
    redirect_to users_url
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end  
    end

    def correct_user
      @user=User.find(params[:id])

      redirect_to root_path, error:"Access Denied" unless current_user?(@user)
    end

     def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
