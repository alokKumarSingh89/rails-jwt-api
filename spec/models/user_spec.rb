require 'rails_helper'

RSpec.describe User, type: :model do
  it "Fails if the don't have any attributes" do
    user = build(:user, email: nil,  password: nil, username: nil)
    expect(user.valid?).to eq false
    expect(user.errors[:email]).to eq(["can't be blank"])  
    expect(user.errors[:password]).to eq(["can't be blank", "can't be blank"])  
    expect(user.errors[:username]).to eq(["can't be blank"])  
  end

  it "Successfully created the user" do
    user = create(:user)
    expect(user.valid?).to eq true
    expect(User.count).to eq(1)  
  end
  it "Duplicate username" do
    create(:user,username: "test")
    user = build(:user, username: "test")
    expect(user.valid?).to eq false
    expect(User.count).to eq(1)
    expect(user.errors[:username]).to eq(["has already been taken"])
  end
  it "another way to validate user" do
    user = build(:user, username: nil,email:nil, password:nil)
    expect(user).to_not be_valid
    expect(user.errors[:username]).to eq(["can't be blank"])
    expect(user.errors[:email]).to eq(["can't be blank"])
    user.email = "test@gmail.com"
    user.username = "test@gmail.com"
    user.password = 'password'
    expect(user).to be_valid
    expect(user.errors[:email]).to eq([])
  end
end
