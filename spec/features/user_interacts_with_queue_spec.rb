require 'spec_helper'

feature "User interacts with the queue" do
	scenario "user adds and reorders video in the queue" do
		comedies = Fabricate(:category)
		monk = Fabricate(:video, title: "Monk", category: comedies)
		futurama = Fabricate(:video, title: "Futurama", category: comedies)
		south = Fabricate(:video, title: "SouthPark", category: comedies)
		
		sign_in
		find("a[href='/videos/#{monk.id}']").click
		page.should have_content(monk.title)
		
		click_link "+ My Queue"
		page.should have_content(monk.title)

		visit video_path(monk)
		page.should_not have_content "+ My Queue"
	end
end