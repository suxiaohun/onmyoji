class CreateYysTips < ActiveRecord::Migration[5.2]
  def change
    create_table :yys_tips do |t|
      t.string :title
      t.text :content
      t.string :category
      t.string :status, default: 'ENABLED'

      t.timestamps
    end
  end
end
