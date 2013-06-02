class CompaniesController < ApplicationController
	before_filter :signed_in_user, only: [:index,:show,:edit,:update,:destroy]
    #before_filter :correct_user, only: []
  before_filter :admin_user, only: [:edit,:update,:destroy,:new]
  def new
  	@company=Company.new
  end
  def create
  	@company = Company.new (params[:company])
  	if @company.save
      #sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
      
  		  redirect_to @company
      
  	else
  		render 'new'
  	end
  end
  def show
  end
  def edit
  end
  def destroy
  end
  def index
  end
  def update
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
