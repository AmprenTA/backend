# frozen_string_literal: true

class Login < Grape::API
  format :json

  desc 'Login Endpoint'
  namespace :login do
    desc 'Login with email and password'
    params do
      requires :email, type: String, desc: 'email'
      requires :password, type: String, desc: 'password'
    end
    post do

      user = User.find_by_email params[:email]
      unless user.present? && user.valid_password?(params[:password])
        error_msg = 'Invalid Credentials'
        error!({ 'error_msg' => error_msg }, 401)
      end
      { "status": 'Successful', "code": 200 }.to_json
    end
  end
end
