require_relative '../spec_helper'

describe "user model" do 
  let (:user) {User.new(first_name: "Jessica", last_name: "Forch", email: "test@test.com", password: "test")}

  it "has a first_name" do 
    expect(user.first_name).to eq("Jessica")
  end 

  it "has a last_name" do 
    expect(user.last_name).to eq("Forch")
  end 

  it "has an email" do 
    expect(user.email).to eq("test@test.com")
  end 

  it "has a password" do 
    expect(user.password).to eq("test")
  end 
end 

describe "route model" do 
  let (:route) {Route.new(origin: "Sonoma, CA", destination: "San Francisco, CA")}

  it "has an origin" do 
    expect(route.origin).to eq("Sonoma, CA")
  end 

  it "has a destination" do 
    expect(route.destination).to eq("San Francisco, CA")
  end
end 

