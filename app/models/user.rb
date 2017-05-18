class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable,
         :recoverable
  has_many :summaries

  def self.find_for_slack_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(first_name:     auth.info.first_name,
                          last_name:     auth.info.last_name,
                              email:     auth.info.email,
                               name:     auth.info.name,
                         profile_img_url:auth.info.image_24,
                           provider:     auth.provider,
                                uid:     auth.uid,
                           password:     Devise.friendly_token[0,20]
      )
    end
    user
  end

end
