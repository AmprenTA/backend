# frozen_string_literal: true

module AuthorizationHelper
  def authorize_user(token)
    key = ENV.fetch('SECRET', nil)
    begin
      decode_data = JWT.decode(token, key, true, { algorithm: 'HS256' })
      user_data = decode_data[0].values.first if decode_data
      user = User.find(user_data)
      error!({ error: 'Unauthorized!' }, 401) unless user
    rescue StandardError => e
      error!({ error: "Unauthorized! #{e}" }, 401)
    end
  end
end