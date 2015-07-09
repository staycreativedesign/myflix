class CreateReviews < ActiveRecord::Migration
  def change
  	create_table :reviews do |t|
  		t.text :description
  		t.integer :video_id, index: true
  		t.string :rating
  		t.integer :user_id
  		t.timestamps
  	end
  end
end
