require 'rails_helper'

feature 'User login' do
  let(:password) { 'P@ssw0rd' }

  before { visit root_url }

  context 'when a user already exists' do
    let!(:user) do
      FactoryGirl.create(:user,
                         password: password,
                         password_confirmation: password)
    end

    scenario 'As a User I can log in and log back out' do
      expect(page).to have_link 'Sign In'
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
      click_button 'Log in'
      expect(page).to have_text 'Signed in successfully'
      expect(page).to have_link 'Sign Out'
      click_link 'Sign Out'
      expect(page).to have_text 'Signed out successfully'
    end
  end
end
