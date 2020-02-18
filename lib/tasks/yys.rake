namespace :yys do

  def init_shi_shen
    YysShiShen.delete_all

    # SSR
    shi_shens = []
    shi_shens << {name: '鬼童丸', sid: '345', cartoon: false}
    shi_shens << {name: '云外镜', sid: '344', cartoon: false}
    shi_shens << {name: '泷夜叉姬', sid: '338', cartoon: true}
    shi_shens << {name: '大岳丸', sid: '333', cartoon: true}
    shi_shens << {name: '不知火', sid: '330', cartoon: true}
    shi_shens << {name: '八岐大蛇', sid: '325', cartoon: true}
    shi_shens << {name: '白藏主', sid: '316', cartoon: true}
    shi_shens << {name: '鬼切', sid: '312', cartoon: true}
    shi_shens << {name: '面灵气', sid: '311', cartoon: true}
    shi_shens << {name: '御馔津', name_sp: '青竹', sid: '304', cartoon: true, cartoon_sp: true}
    shi_shens << {name: '玉藻前', name_sp: '白堇', sid: '300', cartoon: true}
    shi_shens << {name: '山风', name_sp: '青竹', sid: '296', cartoon: true}
    shi_shens << {name: '雪童子', name_sp: '京紫', sid: '292', cartoon: true}
    shi_shens << {name: '彼岸花', name_sp: '白堇', sid: '288', cartoon: true, cartoon_sp: true}
    shi_shens << {name: '荒', name_sp: '山吹', sid: '283', cartoon: true}
    shi_shens << {name: '辉夜姬', name_sp: '绀色', sid: '280', cartoon: true, cartoon_sp: true}
    shi_shens << {name: '花鸟卷', name_sp: '绀色', sid: '279', cartoon: true, cartoon_sp: true}
    shi_shens << {name: '一目连', name_sp: '京紫', sid: '272', cartoon: true, cartoon_sp: true}
    shi_shens << {name: '妖刀姬', name_sp: '真红', sid: '269', cartoon: true}
    shi_shens << {name: '青行灯', name_sp: '浅葱', sid: '266', cartoon: true, cartoon_sp: true}
    shi_shens << {name: '茨木童子', name_sp: '薄香', sid: '265', cartoon: true, cartoon_sp: true}
    shi_shens << {name: '小鹿男', name_sp: '白堇', sid: '259', cartoon: true}
    shi_shens << {name: '阎魔', name_sp: '京紫', sid: '255', cartoon: true, cartoon_sp: true}
    shi_shens << {name: '荒川之主', name_sp: '薄香', sid: '248', cartoon: true}
    shi_shens << {name: '酒吞童子', name_sp: '山吹', sid: '219', cartoon: true}
    shi_shens << {name: '大天狗', name_sp: '青竹', sid: '217', cartoon: true, cartoon_sp: true}

    # SP
    shi_shens << {name: '天剑韧心鬼切', kind: 'SP', sid: '343', cartoon: true}
    shi_shens << {name: '鬼王酒吞童子', kind: 'SP', sid: '341', cartoon: true}
    shi_shens << {name: '烬天玉藻前', kind: 'SP', sid: '339', cartoon: true}
    shi_shens << {name: '骁浪荒川之主', kind: 'SP', sid: '334', cartoon: true}
    shi_shens << {name: '御怨般若', kind: 'SP', sid: '331', cartoon: true}
    shi_shens << {name: '赤影妖刀姬', kind: 'SP', sid: '328', cartoon: true}
    shi_shens << {name: '苍风一目连', kind: 'SP', sid: '327', cartoon: true}
    shi_shens << {name: '稻荷神御馔津', kind: 'SP', sid: '326', cartoon: true}
    shi_shens << {name: '炼狱茨木童子', kind: 'SP', sid: '322', cartoon: true}
    shi_shens << {name: '少羽大天狗', kind: 'SP', sid: '315', cartoon: true}

    # linkage
    shi_shens << {name: '黑崎一护', sid: '337', form: 'linkage'}
    shi_shens << {name: '桔梗', sid: '319', form: 'linkage'}
    shi_shens << {name: '杀生丸', sid: '314', form: 'linkage'}
    shi_shens << {name: '犬夜叉', sid: '313', form: 'linkage'}
    shi_shens << {name: '鬼灯', sid: '308', form: 'linkage'}
    shi_shens << {name: '卖药郎', sid: '305', form: 'linkage'}
    shi_shens << {name: '奴良陆生', sid: '294', form: 'linkage'}


    shi_shens.each do |ss|
      YysShiShen.create!(ss)
      puts "...创建式神：#{ss[:name]}, sid: #{ss[:sid]}"
    end

  end


  def init_tip
    YysTip.delete_all

    tips = []
    tips << {content: ''}


  end

  desc "init yys base related data"
  task init: :environment do
    init_shi_shen
    init_tip
  end

end
