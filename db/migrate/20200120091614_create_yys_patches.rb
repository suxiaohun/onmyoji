class CreateYysPatches < ActiveRecord::Migration[5.2]
  def change
    create_table :yys_patches do |t|
      t.text :content
      
      t.timestamps
    end
  end
end
