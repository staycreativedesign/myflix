def sign_in(a_user=nil)
	user = a_user || Fabricate(:user)
	visit "sign_in/"
	fill_in 'email', with: user.email
	fill_in 'password', with: user.password
	click_button "Sign in"
	page.should have_content "You are signed in, enjoy"
end