User.destroy_all

10.times do |i|
  User.seed(:id) do |s|
    s.id              = i+1
    s.first_name      = "first_name_#{i+1}"
    s.last_name       = "last_name_#{i+1}"
    s.email           = "name_#{i+1}@example.com"
    s.password        = '12345'
    s.profile_img_url = "http://wwww.profile_img_#{i+1}"
  end
end