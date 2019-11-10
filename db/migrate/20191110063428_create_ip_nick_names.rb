class CreateIpNickNames < ActiveRecord::Migration[5.2]
  def change
    create_table :ip_nick_names do |t|
      t.string :ip
      t.string :name
      t.integer :seq, default: 1 # 序列，用来判定

      t.timestamps
    end
  end
end
