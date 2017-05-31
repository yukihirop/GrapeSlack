class Content < ApplicationRecord
  belongs_to :summary

  # [参考] http://bitarts.jp/blog/2015/09/14/rails_url_validate.html
  validates :slack_url, presence:true, format: /\A#{URI::regexp(%w(https://aiming.slack.com/archives/))}\z/
  before_save :member
  before_save :set_attributes

  def set_attriubtes
    return self if self[:slack_url] == ""
    reply   = GrapeSlack::Api::Reply.new(self.slack_url, @member).reply
    self.first_name           = @member['first_name'][reply['id']]
    self.last_name            = @member['last_name'][reply['id']]
    self.name                 = self.first_name + ' ' + self.last_name
    self.nickname             = @member['name'][reply['id']]
    self.profile_image_48_url = @member['image_48'][reply['id']]
    self.slack_message        = reply['text']
    self
  end

  def member
    @member ||= GrapeSlack::Api::Member.new.member
  end

end