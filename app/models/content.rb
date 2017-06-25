class Content < ApplicationRecord
  belongs_to :summary

  include GrapeSlack::Api::ReplyGetable
  include GrapeSlack::Api::MemberGetable

  # [参考] http://bitarts.jp/blog/2015/09/14/rails_url_validate.html
  validates :slack_url, presence:true, format: /\A#{URI::regexp(%w(https))}\z/
  before_validation :member
  before_save :set_attributes

  def set_attributes
    return self if self[:slack_url] == ""
    reply                     = reply(self.slack_url, @member)
    self.first_name           = @member['first_name'][reply['id']]
    self.last_name            = @member['last_name'][reply['id']]
    self.name                 = self.first_name + ' ' + self.last_name
    self.nickname             = @member['name'][reply['id']]
    self.profile_image_48_url = @member['image_48'][reply['id']]
    self.slack_message        = reply['text']
    self
  end

  def member
    #正常に取得できない場合は、false
    @member = member_from_redis
  end

end