class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string    :title, null: false
      t.integer   :isbn, null: false
      t.string    :image_id, null: false
      t.references :category
      t.string    :auther
      t.string    :publisher
      t.datetime  :published_date
      t.integer   :volume
      t.integer   :stock_num, null: false
      t.timestamps
    end
  end
end
