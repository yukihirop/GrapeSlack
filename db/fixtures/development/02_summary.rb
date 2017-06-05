require 'i18n'
I18n.locale = :ja

(30*20).times do |i|
  Summary.seed do |s|
    s.id      = i+1
    s.user_id = 1+(i/20)
    s.title = FFaker::Music.song
  end
end

