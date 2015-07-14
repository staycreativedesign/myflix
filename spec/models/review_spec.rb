require 'spec_helper'

describe Review do
	it { should belong_to :video }
	it { should belong_to :user }
	it { should validate_presence_of :description}
	it { should delegate_method(:full_name).to(:user).with_prefix(:user) }
end