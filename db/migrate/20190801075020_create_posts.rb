class CreatePosts < ActiveRecord::Migration[5.2]

  def up
    create_table :posts do |t|
      t.string :header,:limit => 64
      t.text :content, :limit => 512
      t.integer :position,:default => 0
      t.boolean :visible,:default => true
      t.string :name, :limit => 21
      t.string :location, :limit => 21
      t.string :phone_number, :limit => 12
      t.integer :visitor_count, :default => 0
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :posts, :visible
    add_index :posts, :position
    add_index :posts, :visitor_count
  end

  def down
    drop_table :posts
  end

end
