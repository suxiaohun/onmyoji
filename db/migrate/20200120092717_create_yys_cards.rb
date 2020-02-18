class CreateYysCards < ActiveRecord::Migration[5.2]
  def change
    create_table :yys_cards do |t|
      t.string :nick_name
      t.text :sids

      t.timestamps
    end
    add_index :yys_cards, :nick_name, unique: true
  end
end
