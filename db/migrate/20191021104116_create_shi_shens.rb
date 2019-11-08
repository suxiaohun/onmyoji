class CreateShiShens < ActiveRecord::Migration[5.2]
  def change
    create_table :shi_shens do |t|
      t.string :sid
      t.string :name
      t.string :name_sp
      t.string :mode # ssr / sp
      t.string :kind, default: 'origin' # 原生（origin）/联动（linkage），联动式神不参与抽卡游戏
      t.boolean :cartoon, default: false # 是否有召唤动画
      t.boolean :cartoon_sp, default: false # 是否有sp召唤动画
      t.string :path

      t.timestamps
    end

  end
end
