# frozen_string_literal: true

class UsersApi < Grape::API
  resource :users do
    # GET /users/:id
    route_param :id do
      desc 'Get user' do
        tags %w[users]
        http_codes [
          { code: 200, model: Entities::User, message: 'User info' },
          { code: 404, message: 'User not found!' }
        ]
      end
      params do
        requires :id, type: Integer
      end
      get do
        present User.find(params[:id]), with: Entities::User
      end
    end

    # POST /users/sign_up
    namespace 'sign_up' do
      desc 'User Sign Up' do
        tags %w[users]
        http_codes [
          { code: 201, model: Entities::User, message: 'User created' }
        ]
      end
      params do
        requires :first_name, type: String, desc: 'first_name', documentation: { param_type: 'body' }
        requires :last_name, type: String, desc: 'last_name', documentation: { param_type: 'body' }
        requires :email, type: String, desc: 'email', documentation: { param_type: 'body' }
        requires :password, type: String, desc: 'password', documentation: { param_type: 'body' }
      end
      post do
        user = User.new(
          first_name: params[:first_name],
          last_name: params[:last_name],
          email: params[:email],
          password: params[:password]
        )
        if user.present? && user.valid_password?(params[:password]) && user.save
          token = JWT.encode({ user_data: user.id }, Rails.application.secret_key_base, 'HS256')
          { 'auth-token': token }
        else
          error!(user.errors, 400)
        end
      end
    end

    # POST /users/sign_in
    namespace 'sign_in' do
      desc 'User Sign In' do
        tags %w[users]
        http_codes [
          { code: 201, model: Entities::User, message: 'User logged in!' },
          { code: 401, model: Entities::User, message: 'Forbidden!' }
        ]
      end
      params do
        requires :email, type: String, desc: 'email', documentation: { param_type: 'body' }
        requires :password, type: String, desc: 'password', documentation: { param_type: 'body' }
      end
      post do
        user = User.find_by_email(params[:email])
        unless user.present? && user.valid_password?(params[:password])
          error_msg = 'Invalid Credentials'
          error!({ 'error_msg' => error_msg }, 401)
        end
        token = JWT.encode({ user_data: user.id }, Rails.application.secret_key_base, 'HS256')
        { 'auth-token': token }
      end
    end
  end
end
