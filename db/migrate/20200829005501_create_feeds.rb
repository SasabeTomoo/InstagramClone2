class CreateFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds do |t|
      t.text :image
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
