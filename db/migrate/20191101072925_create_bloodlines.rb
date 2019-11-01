class CreateBloodlines < ActiveRecord::Migration[5.2]
  def change
    create_table :bloodlines do |t|
      t.string :name
      t.string :mode, default: 'AFRICA' # EUROPE
      t.integer :score, default: 0
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
