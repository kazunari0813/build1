class AddimageIdToposts < ActiveRecord::Migration[5.2]
  def change
  	add_column :posts, :image_id, :string
  	# drop_table :post_images
  end
end
