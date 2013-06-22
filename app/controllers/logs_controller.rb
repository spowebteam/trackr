class LogsController < ApplicationController
  def create
    @company=Company.find(params[:log][:company_id])
    can_view_else_redirect(@company)
    @log = @company.logs.build(params[:log])
    if @log.save
      #sign_in @user
      flash[:success] = "Successfully posted"
    end
    redirect_to goback
  end

  def destroy
    @log=Log.find(params[:id])
    @company=Company.find(@log.company_id)
    can_view_else_redirect(@company)
    @log.destroy
    flash[:success]="Log deleted"
    redirect_to goback
  end

  def edit
    @log = Log.find(params[:id])
    @company=Company.find(@log.company_id)
    @contacts=@company.contacts
    can_view_else_redirect(@company)
  end

  def update
    @log=Log.find(params[:id])
    @company=Company.find(@log.company_id)
    can_view_else_redirect(@company)
    if @log.update_attributes(params[:log])
      flash[:success]="Log updated"
      redirect_to @company
    else
      render 'edit'
    end
  end
end