FactoryGirl.define do
  factory :slack_user, class: Slack do
    first_name      'first_name'
    last_name       'last_name'
    email           'name_1@example.com'
    password        '12345'
    profile_img_url 'http://wwww.profile_img_1'
  end
end