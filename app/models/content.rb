class Content < ApplicationRecord
  belongs_to :summary
  before_save :remake_contents

  #selfはContent
  def self.import(contents)
    members = GrapeSlack::Api::Member.new.members
    contents.each do |content|
      #remake_contentsのselfはcontent
      content.remake_contents
    end
    super
  end

  #selfは@summary.contents[n]
  def remake_contents
    members ||= GrapeSlack::Api::Member.new.members
    reply   = GrapeSlack::Api::Reply.new(self.slack_url).reply
    self.first_name           = members['first_name'][reply['id']]
    self.last_name            = members['last_name'][reply['id']]
    self.name                 = self.first_name + ' ' + self.last_name
    self.nickname             = members['name'][reply['id']]
    self.profile_image_48_url = members['image_48'][reply['id']]
    self.slack_message        = reply['text']
  end

end