require 'rails_helper'

RSpec.describe VideoSharesController, type: :feature, js: true do
  include LoginHelper
  let(:user) { User.create(username: "testuser", password: "password", password_confirmation: "password") }
  let(:valid_url) { "https://www.youtube.com/watch?v=dQw4w9WgXcQ" }

  before do
    login(user)
  end

  after do
    VideoShare.destroy_all
    User.destroy_all
  end

  describe "POST create new video share" do
    context "when user is not logged in" do
      it "redirects to session path" do
        click_button "Logout"

        visit new_video_share_path
        expect(page).to have_current_path(sessions_path)
      end
    end

    context "when user is logged in" do
      context "when URL is invalid" do
        it "displays an error message" do
          visit new_video_share_path
          fill_in "url", with: "invalid_url"
          click_button "Submit"
          expect(page).to have_selector("span", text: "Invalid URL")
        end
      end

      context "when URL is valid" do
        context "when video has already been shared by the user" do
          it "displays an error message" do
            # Create for the first time
            visit new_video_share_path
            fill_in "url", with: valid_url
            click_button "Submit"
            # Create for the second time
            visit new_video_share_path
            fill_in "url", with: valid_url
            click_button "Submit"
            expect(page).to have_selector("span", text: "You have already shared this video")
          end
        end
        context "when video has not already been shared by the user" do
          it "redirects to root path and shows video's title" do
            title = "Rick Astley - Never Gonna Give You Up (Official Music Video)"
            visit new_video_share_path
            fill_in "url", with: valid_url
            click_button "Submit"
            expect(page).to have_current_path(my_videos_path)
          end
        end

        context "User shares a video and triggers a notification broadcast to other users" do
          let(:new_user) { User.create(username: "new_user", password: "password", password_confirmation: "password") }

          before(:each) do
            click_button "Logout"
          end
          it 'should broadcast to user 2' do
            using_session(:user) do
              login(user)
            end
            # Log in as user2 in another session
            using_session(:new_user) do
              login(new_user)
            end

            # Share a video as user1
            using_session(:user) do
              visit new_video_share_path
              fill_in "url", with: valid_url
              click_button 'Submit'
            end

            # Check for the notification alert as user2 (replace this with your actual alert check)
            using_session(:new_user) do
              expect(accept_alert).to eq "#{user.username} shared a new video: Rick Astley - Never Gonna Give You Up (Official Music Video)"
            end
          end
        end
      end
    end
  end

  describe "Open homepage" do
    before do
      VideoShare.create(title: "Test Title 1", description: "Test Description 1", thumbnail_url: "http://example.com/thumbnail1", owner_id: user.id)
      VideoShare.create(title: "Test Title 2", description: "Test Description 2", thumbnail_url: "http://example.com/thumbnail2", owner_id: user.id)
    end

    it "displays all shared videos" do
      visit root_path
      expect(page).to have_selector("h5", text: "Test Title 1")
      expect(page).to have_selector("h5", text: "Test Title 2")
    end
  end

  describe "Click Share video button" do
    context "when user is not logged in" do
      before do
        click_button "Logout"
      end

      it "redirects to session path" do
        visit new_video_share_path
        expect(current_path).to eq(sessions_path)
      end
    end

    context "when user is logged in" do
      it "renders form input Youtube URL" do
        visit new_video_share_path
        expect(page).to have_selector("h1", text: "Share a video")
      end
    end
  end

  describe "My shared page" do
    before do
      @video_1 = VideoShare.create(title: "Test Title", description: "Test Description 1", thumbnail_url: "http://example.com/thumbnail1", owner_id: user.id)
    end

    it "displays only the user's videos" do
      visit my_videos_path
      expect(page).to have_selector("h5", text: "Test Title")
    end

    it "displays a link to delete each video" do
      visit my_videos_path
      expect(page).to have_selector('input.btn-delete-video')
    end

    it "deletes the video when the delete button is clicked" do
      visit my_videos_path
      accept_alert do
        click_button "Delete"
      end
      expect(current_path).to eq(my_videos_path)
      expect(page).not_to have_selector("h5", text: "Test Title")

    end
  end
end
