# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.real_name	     "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobarfoo"
  user.password_confirmation "foobarfoo"
end
Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :bookmark do |bookmark|
  bookmark.URL "www.example.com"
  bookmark.association :user
end
