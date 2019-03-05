class CreateFavoritePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :create_favorites do |t|
      t.integer :user_id
      t.integer :posts_id

      t.timestamps
    end
  end
end
