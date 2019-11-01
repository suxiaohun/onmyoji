class CreateRegions < ActiveRecord::Migration[5.2]
  def change
    create_table :regions do |t|
      t.string :key # 大区id，防止每次重建导致匹配失败
      t.string :name
      t.string :mode # 全平台、双平台、安卓、ios

      t.timestamps
    end
  end
end
