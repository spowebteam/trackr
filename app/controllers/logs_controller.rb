class LogsController < ApplicationController
  def create
    @company=Company.find(params[:log][:company_id])
    @log = @company.logs.build(params[:log])
    if @log.save
      #sign_in @user
      flash[:success] = "Successfully posted"
    end
    redirect_to goback
  end


end