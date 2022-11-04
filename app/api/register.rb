# frozen_string_literal: true

class Register < Grape::API
  format :json

  desc 'Register Endpoint'
  namespace :register do
    desc 'Register with email and password'
    params do
      requires :email, type: String, desc: 'email'
      requires :password, type: String, desc: 'password'
    end
    post do
      user = User.new(email: params[:email], password: params[:password])
      unless user.present? && user.valid_password?(params[:password]) && user.save
        error!(user.errors, 400)
      end
      { "status": 'Created', "code": 201 }.to_json
    end
  end
end
