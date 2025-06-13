# frozen_string_literal: true

module BearerTokenGeneratorHelper
  def generate_bearer_token_for(user)
    token, payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)

    AllowlistedJwt.create(
      jti: payload["jti"],
      exp: Time.now + 30.minutes,
      user_id: payload["sub"]
    )

    "Bearer #{token}"
  end
end
