class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.json
  before_filter :admin_user, only: [:index,:destroy,]
  
  def activity
    @contact=Contact.find(params[:id])
    if @contact.company
      can_view_else_redirect(@contact.company)
    elsif current_user.admin?
      flash[:error]="Access Denied"
      redirect_to request.referrer
    end
    @contact.active=params[:active]
    @contact.save
    redirect_to request.referrer
  end

  def index
    if params[:company_id] == nil
      if current_user.superadmin?
        @contacts = Contact.paginate(page: params[:page]).includes(:company)
      elsif current_user.admin?
        @contacts = Contact.paginate(page: params[:page]).includes(:company).where(:active => true)
      else
        flash[:error]="Access Denied"
        redirect_to request.referrer
      end
    else

      @company = Company.find(params[:company_id])
      can_view_else_redirect(@company)
      @contacts = @company.contacts.where(:active => true)
    end
    respond_to do |format|
      format.html # /
      format.json { render json: @contacts}
    end
  end

  def new
    if params[:company_id] == nil
      flash[:error] = "Cannot create contact without company"
      redirect_to root_path
    else

      @company = Company.find(params[:company_id])
      can_view_else_redirect(@company)
      @contact = @company.contacts.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @contact }
      end
    end
  end

  def show_modal
    @company = Company.find(params[:company_id])
    can_view_else_redirect(@company)
    @contact = Contact.find(params[:id])
  end
  def show
    @contact = Contact.find(params[:id])
    if @contact.company_id
      @company = Company.find(@contact.company_id)
      can_view_else_redirect(@company)
    else
      redirect_to request.referrer unless current_user.admin?
    end
    unless @contact
      flash[:error] = "Contact has left the building"
      if @company
        redirect_to @company
      else
        redirect_to contacts
      end
    end
    respond_to do |format|
      format.html 
      format.json {render json: @contact}
    end 
  end
  def edit
    @contact = Contact.find(params[:id])
    @company = Company.find(@contact.company_id)
  end

  # POST /contacts
  # POST /contacts.json
  def create
    unless params[:company_id] then
      flash[:error] = "Cannot create contact without company"
      redirect_to root_path
    end
    @company = Company.find(params[:company_id])
    @contact = @company.contacts.build(params[:contact])

    if @contact.save
      flash[:success] = "Contact added!"
      redirect_to @company
    else
      render 'new'
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])
    @company = Company.find(@contact.company_id)
    if @contact.default
      params[:contact][:default] = true
    end
    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        #if reset_default then

        flash[:success] = "Contact was edited"
        format.html { redirect_to @company}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end
  private
    def correct_user
      redirect_to root_path, error:"Access Denied" unless current_user.poweruser?
    end
end
