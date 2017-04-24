require "spec_helper"

describe Event do
  it { should belong_to(:creator) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:start_time) }
end
