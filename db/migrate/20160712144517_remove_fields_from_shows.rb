class RemoveFieldsFromShows < ActiveRecord::Migration
  def change
    remove_column :shows, :production_company
  end
end
