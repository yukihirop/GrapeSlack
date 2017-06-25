30.times do |i|
  User.seed(:id) do |s|
    g = Gimei.name
    s.id              = i+1
    s.first_name      = g.first.kanji
    s.last_name       = g.last.kanji
    s.name            = g.kanji
    s.nickname        = FFaker::Lorem.characters(5)
    s.email           = FFaker::Internet.email
    s.encrypted_password = FFaker::Internet.password
    s.profile_img_url = "https://pbs.twimg.com/profile_images/447675344175124481/t2AdqcaA.jpeg"
    s.provider        = "slack"
    s.uid             = FFaker::Lorem.characters(5).upcase
  end
end