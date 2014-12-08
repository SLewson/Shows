class BadLoginController < ApplicationController
  def login
    logger.info params
    # TODO: Find users
    @user = User.authenticate(params[:email], params[:password])


    if @user.nil?
      render :json => {:success => false, :message => 'incorrect username or password'}, :status => :unauthorized
    else
      render json: @user
    end
  end
end
