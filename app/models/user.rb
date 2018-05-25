require_relative '../../lib/jwt_encode_decode.rb'
class User < ActiveRecord::Base
  extend JwtEncodeDecode

  validates_presence_of :username, :password
  validates_uniqueness_of :username


end
