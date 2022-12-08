# frozen_string_literal: true

class UsersApi < Grape::API
  format :json

  helpers AuthorizationHelper

  resource :users do
    # GET /users/availability
    namespace 'availability' do
      desc 'Check footprint computation availability' do
        tags %w[users]
        http_codes [
          { code: 200, message: 'Check availability to compute.' }
        ]
      end
      desc 'Headers', {
        headers: {
          'auth_token' => {
            description: 'Validates your identity',
            optional: true
          }
        }
      }
      get do
        token = headers.fetch('Auth-Token', nil)
        return true unless token

        user = authorize_user(token) if token
        last_footprint_date = Footprint.where(user:).max_by(&:created_at)&.created_at&.to_date

        if last_footprint_date
          last_footprint_date + 1.month < Date.current
        else
          true
        end
      end
    end

    # GET /users/:id
    route_param :id do
      desc 'Get user' do
        tags %w[users]
        http_codes [
          { code: 200, model: Entities::User, message: 'User info.' },
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
          { code: 201, model: Entities::User, message: 'User created' },
          { code: 400, message: 'Bad request!' }
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
          auth_token = JWT.encode({ user_data: user.id }, Rails.application.secret_key_base, 'HS256')
          { first_name: user.first_name, last_name: user.last_name, auth_token: }
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

        auth_token = JWT.encode({ user_data: user.id }, Rails.application.secret_key_base, 'HS256')

        { first_name: user.first_name, last_name: user.last_name, auth_token: }
      end
    end
  end
end
