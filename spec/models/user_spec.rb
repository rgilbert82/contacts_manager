require "spec_helper"

describe User do
  it { should have_many(:contacts).dependent(:destroy) }
  it { should have_many(:notes).dependent(:destroy) }
  it { should have_many(:events).dependent(:destroy) }
  it { should have_many(:todos).dependent(:destroy) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
end
