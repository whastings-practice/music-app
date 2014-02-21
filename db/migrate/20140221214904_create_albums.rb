class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, null: false
      t.references :band, index: true, null: false
      t.string :album_type, null: false, limit: 10

      t.timestamps
    end
  end
end
