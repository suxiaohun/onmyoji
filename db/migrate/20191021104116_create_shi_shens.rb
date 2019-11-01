class CreateShiShens < ActiveRecord::Migration[5.2]
  def change
    create_table :shi_shens do |t|
      t.string :sid
      t.string :name
      t.string :mode # ssr / sp
      t.string :kind, default: 'origin' # 原生（origin）/联动（linkage），联动式神不参与抽卡游戏
      t.string :path

      t.timestamps
    end

  end
end
