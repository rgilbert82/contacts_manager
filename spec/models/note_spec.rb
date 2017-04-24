require "spec_helper"

describe Note do
  it { should belong_to(:creator) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
end
