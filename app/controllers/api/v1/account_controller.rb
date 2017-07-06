class Api::V1::AccountController < ApplicationController
  before_action :authorize_account!, except: [:create]

  # POST '/signup'
  def create
    begin
      account = Account.find_by(username: params[:account][:username])
    rescue Mongoid::Errors::DocumentNotFound
      if @account = Account.create(account_params)
        token = JWT.encode( {id: @account.id}, ENV['JWT_SECRET'], ENV['JWT_ALGORITHM'])
        render json: {
          account: {
            username: @account.username,
            first_name: @account.first_name,
            last_name: @account.last_name
            },
          token: token
        }
      else
        render json: { error: @account.errors.full_messages }
      end
      return
    end
    render json: { error: "A user already exists with that username." }
  end

  def update
    @current_account.update(account_params)

    if @current_account.save
      render json: @current_account
    else
      render json: { error: @current_account.errors.full_messages }
    end
  end

  private
  def account_params
    params.require(:account).permit(:username, :password, :first_name, :last_name)
  end
end
