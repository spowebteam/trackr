class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.json
  before_filter :correct_user
  
  def new
    @company = Company.find(params[:company_id])
    @contact = @company.contacts.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.json
  def create
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

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
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
