class Content < ApplicationRecord
  belongs_to :summary

  validates :slack_url,            presence:true
  before_validation :members
  before_validation :remake_contents

  def remake_contents
    return self if self[:slack_url] == ""
    reply   = GrapeSlack::Api::Reply.new(self.slack_url, @members).reply
    self.first_name           = @members['first_name'][reply['id']]
    self.last_name            = @members['last_name'][reply['id']]
    self.name                 = self.first_name + ' ' + self.last_name
    self.nickname             = @members['name'][reply['id']]
    self.profile_image_48_url = @members['image_48'][reply['id']]
    self.slack_message        = reply['text']
    self
  end

  def members
    @members ||= GrapeSlack::Api::Member.new.members
  end

end