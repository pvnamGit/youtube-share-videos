class AddThumbnailUrlToVideoShares < ActiveRecord::Migration[6.0]
  def change
    add_column :video_shares, :thumbnail_url, :string
  end
end
