class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.float :rating
      t.text :description
      t.string :title

      t.timestamps
    end
  end
end
