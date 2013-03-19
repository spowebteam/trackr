namespace :db do 
  desc "Fill with dummy data"
  task populate: :environment do
    User.create!(name:"Dummy User",
                 email:"someone@manyu.in",
                 password:"foobar",
                 password_confirmation:"foobar",
                 identifier:"thedummyuser",
                 phone:"+91000000")
    99.times do |n|
      name=Faker::Name.name
      email="some-#{n+1}@manyu.in"
      password="password"
      identifier="thedummy#{n+1}"
      phone="+910000111222"
      User.create!(name:name,
                 email: email,
                 password:password,
                 password_confirmation:password,
                 identifier:identifier,
                 phone:phone)
    end
  end

end