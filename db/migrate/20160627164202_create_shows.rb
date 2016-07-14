class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :locations
      t.string :production_company
      t.string :title
      t.string :director

      t.timestamps null: false
    end
  end
end
