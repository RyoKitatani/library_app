class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :user
      t.references :book
      t.timestamps
    end
  end
end
