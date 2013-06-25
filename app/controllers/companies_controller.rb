class CompaniesController < ApplicationController
	before_filter :signed_in_user, only: [:index,:show,:edit,:update,:destroy]

    #before_filter :correct_user, only: []
  before_filter :admin_user, only: [:destroy,:new,:create]
  
  autocomplete :user, :name, :full => true 
  def new
  	@company=Company.new
  end
  def create
  	@company = Company.new (params[:company])
  	if @company.save
      #sign_in @user
  		flash[:success] = "Welcome to the Student Placement Office, IIT Kanpur!"
      
  		  redirect_to @company
      
  	else
  		render 'new'
  	end
  end
  def show
    @company=Company.find(params[:id])
    can_view_else_redirect (@company)
    @contacts=@company.contacts
    @default=@company.default_contact
    @logs=@company.logs.order("created_at DESC").paginate(page: params[:page])
    @newlog=@company.logs.build
  end
  def edit
    @company=Company.find(params[:id])
    @contacts=@company.contacts.where(:active => true)
    can_view_else_redirect (@company)
  end
  def destroy
    Company.find(params[:id]).destroy
    flash[:success]="Company Profile Deleted."
    redirect_to companies_url
  end
  def index
    @counterstart=1;
    if current_user.superadmin?
      @companies=Company.all
    elsif current_user.admin?
      @companies=Company.where(:active => true)
    else
      @companies=[]
      @allcompanies=Company.where(:active => true).all(:include => :teams)
      @allcompanies.each do |company|
        @companies << company unless (company.teams & current_user.teams).empty?
      end
    end
    
  end
  def update
    @company=Company.find(params[:id])
    can_view_else_redirect (@company)
    if @company.update_attributes(params[:company])
        flash[:success]="Profile updated"
        #sign_in @user
        redirect_to @company
    else
      render 'edit'
    end
  end
  def updatestatus
    @company=Company.find(params[:id])
    can_view_else_redirect (@company)
    @company.status=params[:status]
    @company.save
    redirect_to @company
  end
  def activity
    @company=Company.find(params[:id])
    can_view_else_redirect (@company)
    @company.active=params[:active] if params[:active]
    @company.save
    redirect_to @company
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
