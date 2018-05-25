module JwtEncodeDecode
  def encode_jwt_token(payload_obj)
    exp = Time.now.to_i + 4 * 3600
    exp_payload = {data: payload_obj, exp: exp}
    token = JWT.encode exp_payload, self.get_hmac_secret, 'HS256'
    # enc_token = Base64.encode64(token)
  end


  def decode_jwt_token(jwt_token)
    # hmac_secret = Rails.application.secrets.jwt_hmac_key1
    decoded_token = JWT.decode jwt_token, self.get_hmac_secret, true, {algorithm: 'HS256'}
  end


  # private
  def get_hmac_secret
    Rails.application.secrets.jwt_hmac_key
  end
end