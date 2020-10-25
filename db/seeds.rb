#
User.create!(name:  "ex",
             email: "ex@railstutorial.org",
             password:              "password",
             password_confirmation: "password",
             admin: true
           )


#適当な名前を持つユーザを99人つくる
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
