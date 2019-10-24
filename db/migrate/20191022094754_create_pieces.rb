class CreatePieces < ActiveRecord::Migration[5.2]
  def change
    create_table :pieces do |t|
      t.string :sama
      t.string :sid
      t.string :mode, default: 'NEED' # NEED、OWN
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
