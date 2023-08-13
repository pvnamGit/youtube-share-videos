class CreateVideoShares < ActiveRecord::Migration[6.0]
  def change
    create_table :video_shares do |t|
      t.string :title
      t.string :description
      t.string :url
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
