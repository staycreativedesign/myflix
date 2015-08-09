require 'spec_helper'

feature	'User signs in' do
	scenario "with existimg email" do
		sign_in
		page.should have_content "You are signed in, enjoy"
	end
end