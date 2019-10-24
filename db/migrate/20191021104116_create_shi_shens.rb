class CreateShiShens < ActiveRecord::Migration[5.2]
  def change
    create_table :shi_shens do |t|
      t.string :sid
      t.string :name
      t.string :mode
      t.string :path

      t.timestamps
    end

  end
end
