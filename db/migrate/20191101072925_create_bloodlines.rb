class CreateBloodlines < ActiveRecord::Migration[5.2]
  def change
    create_table :bloodlines do |t|
      t.string :name
      t.string :mode, default: 'AFRICA' # EUROPE
      t.string :category, default: 'COMMON' # 类型：通用（COMMON）、特殊（SPECIAL）、唯一（UNIQUE）
      t.integer :seq # 标志位
      t.string :title # 称号
      t.string :uniq_flag # UNIQUE标识位
      t.string :remark # 称号描述
      t.integer :score, default: 0
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
