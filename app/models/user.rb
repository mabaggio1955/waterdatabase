class User < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :email, :google_uid, uniqueness: true

  def self.find_or_create_with_omniauth(auth)
    p auth
    user = self.find_or_create_by(email: auth.info.email, google_uid: auth.uid.to_s)
    user.assign_attributes({
      google_uid: auth.uid,
      name: auth.info.name,
      email: auth.info.email,
      google_token: auth.credentials.token,
      oauth_expires_at: Time.at(auth.credentials.expires_at),
    })
    user.save
    user
  end
end
