class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :nick_name
      t.text :sids

      t.timestamps
    end
    add_index :cards, :nick_name, unique: true
  end
end
