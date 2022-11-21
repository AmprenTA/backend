# frozen_string_literal: true

module AuthorizationHelper
  def authorize_user(token)
    key = Rails.application.secret_key_base
    begin
      decode_data = JWT.decode(token, key, true, { algorithm: 'HS256' })
      user_data = decode_data[0].values.first if decode_data
      User.find(user_data)
    rescue StandardError => e
      error!({ error: "Unauthorized! #{e}" }, 401)
    end
  end
end
