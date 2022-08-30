require 'rails_helper'

RSpec.describe User, type: :model do
  it "Fails if the don't have any attributes" do
    user = User.create
    user.validate
    expect(user.errors[:email]).to eq(["can't be blank"])  
    expect(user.errors[:password]).to eq(["can't be blank", "can't be blank"])  
    expect(user.errors[:username]).to eq(["can't be blank"])  
  end

  it "Successfully created the user" do
    User.create!(email: "test@example.com", username: "test", password: "password")
    expect(User.count).to eq(1)  
  end
  it "Duplicate username" do
    User.create!(email: "test@example.com", username: "test", password: "password")
    user = User.create(email: "test@example.com", username: "test", password: "password")
    user.validate
    expect(User.count).to eq(1)
    expect(user.errors[:username]).to eq(["has already been taken"])
  end
  
end
