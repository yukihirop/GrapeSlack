require 'i18n'
I18n.locale = :ja

(30*20*20).times do |i|
  Content.seed do |s|
    g = Gimei.name
    s.id            = 1+i
    s.user_id       = 1+i/(20*20)
    s.summary_id    = 1+i/20
    s.first_name    = g.first.kanji
    s.last_name     = g.last.kanji
    s.name          = g.kanji
    s.nickname      = FFaker::Lorem.characters(5)
    s.slack_message = FFaker::LoremJA.paragraph(30)
    s.slack_url     = FFaker::Internet.http_url
    s.profile_image_48_url = "https://pbs.twimg.com/profile_images/447675344175124481/t2AdqcaA.jpeg"
  end
end
