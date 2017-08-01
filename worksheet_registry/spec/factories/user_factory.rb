FactoryGirl.define do
  factory :user, class: User do
    first_name 'guest'
    second_name 'guested'
    login 'guest'
    password 'guest'
    token { JWT.encode({ login: 'guest', password: 'guest' }, nil, 'none') }
  end
end
