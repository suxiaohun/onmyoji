module XiuxianName
  attr_accessor :attr1, :attr2, :attr_type, :type_name, :group_name, :item_name

  def attr1
    [
        "九陽", "九陰", "八九", "至尊", "無極", "太虛", "洪荒", "天幻", "妙空", "妙有",
        "純陽", "道真", "九龍", "真幻", "大藏", "天魔", "聖魔", "神魔", "天佛", "菩提",
        "青龍", "白虎", "鳳凰", "玄武", "騰蛇", "麒麟", "般若", "燭龍", "盛滅", "末法",
        "千鶴", "萬劍", "剎那", "卍咒", "皇霸", "真龍", "滅絕", "如來", "三聖", "九天",
        "九煌", "軒轅", "日月", "星辰", "絕塵", "太清", "聖言", "死海", "地獄", "狂天",
        "伏羲", "女媧", "洪荒", "真武", "萬象", "太乙", "乾元", "混元", "梵天", "輪迴",
        "真禪", "火源", "夢迴", "聖極", "絕念", "空幻", "七色", "虹輝", "三才", "太元",
        "聖靈", "朔望", "夢彩", "宿飛", "星迴", "紫霄", "千峰", "苦嘆", "聖殤", "絕華",
    ]
  end


  def attr2
    ["紫霞", "七星", "星霞", "古蜀", "紅霞", "幻海", "赤焰", "飛星", "煉獄", "紫光",
     "流劍", "絕刀", "八卦", "雙燕", "迷魂", "墨羽", "定海", "閃光", "星爆", "彌勒",
     "靈蛇", "水鏡", "飛雪", "洛英", "森羅", "碧雲", "天狼", "孤星", "天照", "流光",
     "五彩", "天羅", "碎星", "定天", "極樂", "八卦", "天蠶", "地藏", "巽風", "風舞",
     "血陽", "蒼羽", "屠羅", "飛霜", "流風", "狂嵐", "無雙", "星月", "真日", "證道",
     "四象", "虛空", "浪濤", "迷魂", "陰陽", "靈霄", "太歲", "太白", "極上", "輪轉",
     "孤月", "弦月", "怒濤", "淒煌", "靈狐", "轉生", "無垠", "無垢", "無限", "百仙",
     "天罡", "仁王", "修羅", "羅剎", "菩薩", "蛇蠍", "五毒", "虎嘯", "蓮花", "七曜",
     "風雨", "百花", "金光", "六道", "巨靈", "琉璃", "七寶", "瀟湘", "縹緲", "無痕",
     "無量", "勾魂", "離夢", "蒼穹", "昊天", "冥道", "絕淵", "破天", "十方", "威震",
    ]
  end


  def type_name
    ["功", "圖", "咒", "錄", "訣", "譜", "典", "書", "經", "卷",
     "抄", "法", "術",
    ]
  end


  def item_name
    [
        "譜", "琴", "畫", "卷", "蕭", "盒", "鏡", "扇", "瓶", "珠",
        "劍", "刀", "鐘", "鼎", "印", "石", "如意", "玉", "旗", "杖",
        "傘", "塔", "筆", "環", "鼓", "槍", "鐲", "輪", "壺", "尺",
    ]
  end

  def attr_type
    [
        "聖", "禁", "大", "秘", "真", "古", "絕", "神", "靈", "奇",
        "寶", "之", "無上", "神仙", "心",
    ]
  end

  def group_name
    [
        "世家", "教", "派", "門", "幫", "會", "堂", "樓", "宮", "寺",
        "宗", "大寨", "峰", "道", "院", "殿", "觀",
    ]

  end

  def rand_skill
    a1 = attr1[rand(attr1.size) - 1]
    a2 = attr2[rand(attr2.size) - 1]
    t = type_name[rand(type_name.size) - 1]
    a = attr_type[rand(attr_type.size) - 1]

    _seed = rand

    if _seed < 0.2
      a1 + a2 + a + t
    elsif _seed < 0.4
      a2 + a1 + a + t
    elsif _seed < 0.6
      a1 + a + t
    elsif _seed < 0.8
      a2 + a + t
    else
      a1 + a2 + t
    end
  end

  def rand_item
    a1 = attr1[rand(attr1.size) - 1]
    a2 = attr2[rand(attr2.size) - 1]
    a3 = attr2[rand(attr2.size) - 1]
    i = item_name[rand(item_name.size) - 1]

    _seed = rand

    if _seed < 0.2
      a1 + a2 + i
    elsif _seed < 0.4
      a2 + a1 + i
    elsif _seed < 0.6
      a1 + '之' + i
    elsif _seed < 0.8
      a2 + '之' + i
    else
      a3 + a2 + i
    end
  end

  def rand_group
    a2 = attr2[rand(attr2.size) - 1]
    g = group_name[rand(group_name.size) - 1]
    a2 + g
  end

end

