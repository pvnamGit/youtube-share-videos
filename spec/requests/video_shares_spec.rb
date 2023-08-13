require 'rails_helper'

RSpec.describe VideoSharesController, type: :request do
  before do
    @user = User.create(:username => 'test_login', :password => 'password')
    post sessions_path, params: { username: 'test_login', password: 'password' }
  end

  after do
    VideoShare.destroy_all
    User.destroy_all
  end
  describe "Share video" do
    let(:valid_url) { { url: 'https://www.youtube.com/watch?v=wvCK1g3nYbM' } }
    context "create video share with logged in" do

      it "sets message invalid url" do
        invalid_url = 'https://www.youtube.com/watch?v=abc123/xyz789'
        post video_shares_path, params: { url: invalid_url }
        expect(flash[:error] = "Invalid URL")
      end


      it "not allow one user share same url" do
        post video_shares_path, params: valid_url
        post video_shares_path, params: valid_url
        expect(flash[:error] = "You have already shared this video")
      end

      it 'sets flash error message if video is not shared successfully' do
        allow_any_instance_of(VideoShare).to receive(:save).and_return(false)

        post video_shares_path, params: valid_url

        expect(flash[:alert]).to eq("Fail to share video")
      end

      it "get right title and description from url" do
        expected_title = 'Miyamoto Musashi - 7 Ways To Stay Focused'
        expected_description = 'Miyamoto Musashi is considered to be the greatest swordsman ever in the history of Japan'
        post video_shares_path, params: valid_url

        video = VideoShare.find_by(valid_url)

        expect(video.title).to include(expected_title)
        expect(video.description).to include(expected_description)
      end
    end
    context "create video share without logged in" do
      it 'not allowed to share' do
        post video_shares_path, params: valid_url
        expect(flash[:alert] = "You need to sign in or sign up before continuing.")
      end
    end
  end

  describe "get my shared videos" do
    context "when the user is signed in" do
      it "returns http success" do
        get my_videos_path
        expect(response).to have_http_status(:success)
      end

      it "assigns @my_videos" do
        VideoShare.create(title: "Test Title", description: "Test Description 1", thumbnail_url: "http://example.com/thumbnail1", owner_id: @user.id)
        VideoShare.create(title: "Test Title 2", description: "Test Description 2", thumbnail_url: "http://example.com/thumbnail1", owner_id: @user.id)
        get my_videos_path
        expect(assigns(:my_videos)).to eq(@user.video_shares.all.order(created_at: :desc))
      end
    end
    context "when user is not authenticated" do
      it "redirects to sign up page" do
        expect redirect_to(sessions_path)
      end
    end
  end

  describe "delete videos" do
    let(:video) { VideoShare.create(title: "Test Title", description: "Test Description 1", thumbnail_url: "http://example.com/thumbnail1", owner_id: @user.id) }
    before do
      delete video_share_path(video.id)
    end

    it 'deletes the video share' do
      expect(VideoShare.exists?(video.id)).to be false
    end

    it 'redirects to the root path' do
      expect(response).to redirect_to(my_videos_path)
    end
  end
end
