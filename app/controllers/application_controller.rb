class ApplicationController < ActionController::API
  private
  def token
    token = request.headers['Authorization']
  end

  def decode(token)
    JWT.decode(token, ENV['JWT_SECRET'], true, {algorithm: ENV['JWT_ALGORITHM']})
    rescue JWT::DecodeError
      nil
  end

  def current_account
    if decode(token).present?
      @current_account ||= Account.find_by(id: decode(token)[0]["id"]["$oid"])
    end
  end

  def authorize_account!
    current_account
    if !@current_account.present?
      render json: {error: 'Invalid authorization'} and return
    end
  end
end
