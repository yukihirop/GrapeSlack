class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :summary

  def self.find_for_slack_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(first_name:     auth.info.first_name,
                          last_name:     auth.info.last_name,
                               email:    auth.info.email,
                           provider: auth.provider,
                                uid:      auth.uid,
                         password: Devise.friendly_token[0,20]
      )
    end
    user
  end

end
