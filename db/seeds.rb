# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

start_time = Time.now

puts 'start...'
puts

puts '    start init base data...'
# Author.delete_all
# author_array = [{name: '佚名'},
#                 {name: '默默猴'},
#                 {name: '血红'},
#                 {name: 'lido'},
#                 {name: '冰山男子'},
#                 {name: '玄雨'},
#                 {name: '李鸿天'},
#                 {name: 'zhttty'},
#                 {name: '苏小魂'}]
#
# @authors = Author.create(author_array).inject({}) { |r, x| r[x.id] = x.name; r }
#
# def self.get_author(name)
#   @authors.key(name) || @authors.key('佚名')
# end
#
#
# def get_pre_content(path)
#   pre_content = '......'
#   begin
#     File.open(path) do |io|
#       pre_content = io.gets.chomp
#       10.times { |x| pre_content += io.gets.chomp }
#     end
#   rescue => e
#     # pre_content = '书籍丢失，联系管理员.'
#   end
#   pre_content
# end
#
#
# Category.delete_all
# category_array = [
#     {name: '玄幻'},
#     {name: '科幻'},
#     {name: '武侠'},
#     {name: '名著'},
#     {name: '异能'},
#     {name: '都市'},
#     {name: '异界'},
#     {name: '无限流'},
#     {name: '架空'}
# ]
#
# categories = Category.create(category_array).inject({}) { |r, x| r[x.id] = x.name; r }
#
# Book.delete_all
#
# puts '    start create books...'
#
# book_array = [
#     # {
#     #     name: '墨邪录',
#     #     display_name: '墨邪录',
#     #     author_id: get_author('苏小魂'),
#     #     tag: '玄幻|修真|异界|神话',
#     #     category_id: categories.key('玄幻'),
#     #     path: 'public/books/yaodaoji.txt'
#     # },
#     {
#         name: '无限恐怖',
#         display_name: '无限恐怖',
#         author_id: get_author('默默猴'),
#         tag: '无限流|轮回',
#         category_id: categories.key('无限流'),
#         path: 'public/books/wuxiankongbu.txt'
#     },
#     {
#         name: '妖刀记',
#         display_name: '【妖刀记】【1-50卷（第一部）完结】',
#         author_id: get_author('默默猴'),
#         tag: '武侠',
#         category_id: categories.key('武侠'),
#         path: 'public/books/yaodaoji.txt'
#     },
#     {
#         name: '照日天劫',
#         display_name: '照日天劫',
#         author_id: get_author('默默猴'),
#         tag: '武侠',
#         category_id: categories.key('武侠'),
#         path: 'public/books/zhaoritianjie.txt'
#     },
#     {
#         name: '回归战队',
#         display_name: '回归战队',
#         author_id: get_author('默默猴'),
#         tag: '都市|机甲',
#         category_id: categories.key('都市'),
#         path: 'public/books/huiguizhandui.txt'
#     },
#     {
#         name: '升龙道',
#         display_name: '升龙道',
#         author_id: get_author('血红'),
#         tag: '都市|玄幻',
#         category_id: categories.key('玄幻'),
#         path: 'public/books/shenglongdao.txt'
#     },
#     {
#         name: '逆龙道',
#         display_name: '逆龙道',
#         author_id: get_author('血红'),
#         tag: '都市|玄幻',
#         category_id: categories.key('玄幻'),
#         path: 'public/books/nilongdao.txt'
#     },
#     {
#         name: '征神领域',
#         display_name: '征神领域',
#         author_id: get_author('冰山男子'),
#         tag: '都市|异能',
#         category_id: categories.key('异能'),
#         path: 'public/books/zhengshenlingyu.txt'
#     },
#     {
#         name: '小兵传奇',
#         display_name: '小兵传奇',
#         author_id: get_author('玄雨'),
#         tag: '未来|科幻|舰队',
#         category_id: categories.key('科幻'),
#         path: 'public/books/xiaobingchuanqi.txt'
#     },
#     {
#         name: '异世界的美食家',
#         display_name: '异世界的美食家',
#         author_id: get_author('李鸿天'),
#         tag: '异界|厨神|修真',
#         category_id: categories.key('玄幻'),
#         path: 'public/books/yishijiedemeishijia.txt'
#     }
# ]
# books = Book.create(book_array)
#
# puts '    start init books pre content...'
#
# books.each do |book|
#   book.pre_content = get_pre_content(book.path)
#   book.save!
# end

# 玉藻前·白堇<br>
#     小鹿男·白堇<br>
# <br>
#     妖刀姬·真红<br>
#
#     山风·青竹<br>
#     酒吞童子·青竹<br>
# <br>
#     雪童子·京紫<br>
#     茨木童子·薄香<br>
#     荒川之主·薄香<br>
# <br>
#     青行灯·绀色<br>
# <br>
#     荒·山吹<br>
# init yys data
ShiShen.delete_all
# SSR
shi_shens = []
shi_shens << {name: '泷夜叉姬', mode: 'SSR', sid: '338', cartoon: true}
shi_shens << {name: '黑崎一护', mode: 'SSR', sid: '337', kind: 'linkage'}
shi_shens << {name: '大岳丸', mode: 'SSR', sid: '333', cartoon: true}
shi_shens << {name: '不知火', mode: 'SSR', sid: '330', cartoon: true}
shi_shens << {name: '八岐大蛇', mode: 'SSR', sid: '325', cartoon: true}
shi_shens << {name: '桔梗', mode: 'SSR', sid: '319', kind: 'linkage'}
shi_shens << {name: '白藏主', mode: 'SSR', sid: '316', cartoon: true}
shi_shens << {name: '杀生丸', mode: 'SSR', sid: '314', kind: 'linkage'}
shi_shens << {name: '犬夜叉', mode: 'SSR', sid: '313', kind: 'linkage'}
shi_shens << {name: '鬼切', mode: 'SSR', sid: '312', cartoon: true}
shi_shens << {name: '面灵气', mode: 'SSR', sid: '311', cartoon: true}
shi_shens << {name: '鬼灯', mode: 'SSR', sid: '308', kind: 'linkage'}
shi_shens << {name: '卖药郎', mode: 'SSR', sid: '305', kind: 'linkage'}
shi_shens << {name: '御馔津', name_sp: '青竹', mode: 'SSR', sid: '304', cartoon: true, cartoon_sp: true}
shi_shens << {name: '玉藻前', name_sp: '白堇', mode: 'SSR', sid: '300', cartoon: true}
shi_shens << {name: '山风', name_sp: '青竹', mode: 'SSR', sid: '296', cartoon: true}
shi_shens << {name: '奴良陆生', mode: 'SSR', sid: '294', kind: 'linkage'}
shi_shens << {name: '雪童子', name_sp: '京紫', mode: 'SSR', sid: '292', cartoon: true}
shi_shens << {name: '彼岸花', name_sp: '白堇', mode: 'SSR', sid: '288', cartoon: true, cartoon_sp: true}
shi_shens << {name: '荒', name_sp: '山吹', mode: 'SSR', sid: '283', cartoon: true}
shi_shens << {name: '辉夜姬', name_sp: '绀色', mode: 'SSR', sid: '280', cartoon: true, cartoon_sp: true}
shi_shens << {name: '花鸟卷', name_sp: '绀色', mode: 'SSR', sid: '279', cartoon: true, cartoon_sp: true}
shi_shens << {name: '一目连', name_sp: '京紫', mode: 'SSR', sid: '272', cartoon: true, cartoon_sp: true}
shi_shens << {name: '妖刀姬', name_sp: '真红', mode: 'SSR', sid: '269', cartoon: true}
shi_shens << {name: '青行灯', name_sp: '浅葱', mode: 'SSR', sid: '266', cartoon: true, cartoon_sp: true}
shi_shens << {name: '茨木童子', name_sp: '薄香', mode: 'SSR', sid: '265', cartoon: true, cartoon_sp: true}
shi_shens << {name: '小鹿男', name_sp: '白堇', mode: 'SSR', sid: '259', cartoon: true}
shi_shens << {name: '阎魔', name_sp: '京紫', mode: 'SSR', sid: '255', cartoon: true, cartoon_sp: true}
shi_shens << {name: '荒川之主', name_sp: '薄香', mode: 'SSR', sid: '248', cartoon: true}
shi_shens << {name: '酒吞童子', name_sp: '山吹', mode: 'SSR', sid: '219', cartoon: true}
shi_shens << {name: '大天狗', name_sp: '青竹', mode: 'SSR', sid: '217', cartoon: true, cartoon_sp: true}

# SP
shi_shens << {name: '天剑韧心鬼切', mode: 'SP', sid: '343', cartoon: true}
shi_shens << {name: '鬼王酒吞童子', mode: 'SP', sid: '341', cartoon: true}
shi_shens << {name: '烬天玉藻前', mode: 'SP', sid: '339', cartoon: true}
shi_shens << {name: '骁浪荒川之主', mode: 'SP', sid: '334', cartoon: true}
shi_shens << {name: '御怨般若', mode: 'SP', sid: '331', cartoon: true}
shi_shens << {name: '赤影妖刀姬', mode: 'SP', sid: '328', cartoon: true}
shi_shens << {name: '苍风一目连', mode: 'SP', sid: '327', cartoon: true}
shi_shens << {name: '稻荷神御馔津', mode: 'SP', sid: '326', cartoon: true}
shi_shens << {name: '炼狱茨木童子', mode: 'SP', sid: '322', cartoon: true}
shi_shens << {name: '少羽大天狗', mode: 'SP', sid: '315', cartoon: true}


shi_shens.each do |ss|
  puts "...创建式神：#{ss[:name]}"
  ShiShen.create!(ss)
end

puts '.........................'
puts '.........................'

Region.delete_all
regions = []

# 中国区-iOS
regions << {name: '春之樱', mode: 'IOS', key: 'chunzhiying'}
regions << {name: '夏之蝉', mode: 'IOS', key: 'xiazhichan'}
regions << {name: '夜之月', mode: 'IOS', key: 'yezhiyue'}
regions << {name: '竹之幽', mode: 'IOS', key: 'zhuzhiyou'}
regions << {name: '松之苍', mode: 'IOS', key: 'songzhicang'}
regions << {name: '兰之雅', mode: 'IOS', key: 'langzhiya'}
regions << {name: '雀之羽', mode: 'IOS', key: 'quezhiyu'}
regions << {name: '云之遏', mode: 'IOS', key: 'yunzhijie'}
regions << {name: '莲之净', mode: 'IOS', key: 'lianzhijing'}
regions << {name: '桂之馥', mode: 'IOS', key: 'guizhimi'}

# 中国区-Android
regions << {name: '菊之逸', mode: 'ANDROID', key: 'juzhiyi'}
regions << {name: '雀之灵', mode: 'ANDROID', key: 'quezhiling'}
regions << {name: '暮之霞', mode: 'ANDROID', key: 'muzhixia'}
regions << {name: '冬之雪', mode: 'ANDROID', key: 'dongzhixue'}
regions << {name: '秋之枫', mode: 'ANDROID', key: 'qiuzhifeng'}
regions << {name: '雨之霁', mode: 'ANDROID', key: 'yuzhiji'}
regions << {name: '桃之华', mode: 'ANDROID', key: 'taozhihua'}
regions << {name: '风之清', mode: 'ANDROID', key: 'fengzhiqing'}
regions << {name: '梅之寒', mode: 'ANDROID', key: 'meizhihan'}
regions << {name: '樱之华', mode: 'ANDROID', key: 'yingzhihua'}

# 网易-双平台
regions << {name: '携手同心', mode: 'NET', key: 'xieshoutongxin'}
regions << {name: '结伴同游', mode: 'NET', key: 'jiebantongyou'}
regions << {name: '相伴相随', mode: 'NET', key: 'xiangbanxiangsui'}
regions << {name: '情比金坚', mode: 'NET', key: 'qingbijinjian'}
regions << {name: '形影不离', mode: 'NET', key: 'xingyingbuli'}
regions << {name: '同心一意', mode: 'NET', key: 'tongxinyiyi'}
regions << {name: '相知相依', mode: 'NET', key: 'xianzhixianyi'}
regions << {name: '心意相通', mode: 'NET', key: 'xinyixiangtong'}
regions << {name: '永生之谜', mode: 'NET', key: 'yongshnegzhipi'}
regions << {name: '缥缈之旅', mode: 'NET', key: 'piaomiaozhilve'}
regions << {name: '遥远之忆', mode: 'NET', key: 'yaoyuanzhiyi'}
regions << {name: '孤高之心', mode: 'NET', key: 'gugaozhixin'}
regions << {name: '风雨同行', mode: 'NET', key: 'fenyutongxing'}
regions << {name: '两情相悦', mode: 'NET', key: 'liangqingxiangyue'}
regions << {name: '春樱共赏', mode: 'NET', key: 'chunyinggongshang'}
regions << {name: '谜之暗影', mode: 'NET', key: 'mizhianying'}

# 联运-双平台
regions << {name: 'B站~两心无间', mode: 'UNION', key: 'liangxinwujian'}
regions << {name: 'B站~亲密无间', mode: 'UNION', key: 'qinmiwujian'}
regions << {name: 'B站~情深谊长', mode: 'UNION', key: 'qingshenyichang'}
regions << {name: 'B站~情意相投', mode: 'UNION', key: 'qingyixiangtou'}

# 国际区
regions << {name: '海外加速区', mode: 'INT', key: 'haiwaijiasuqu'}

# 全平台互通新区
regions << {name: '相伴同行', mode: 'ALL', key: 'xiangbantongxing'}
regions << {name: '旧友新朋', mode: 'ALL', key: 'jiuyouxinpeng'}
regions << {name: '深情厚谊', mode: 'ALL', key: 'shenqinghouyi'}
regions << {name: '相伴长情', mode: 'ALL', key: 'xiangbanchangqing'}
regions << {name: '朝夕相伴', mode: 'ALL', key: 'zhaoxixiangban'}
regions << {name: '携手共度', mode: 'ALL', key: 'xieshougongdu'}
regions << {name: '举手相庆', mode: 'ALL', key: 'jushouxiangqing'}
regions << {name: '欢庆鼓舞', mode: 'ALL', key: 'huanqingguwu'}
regions << {name: '追月逐兔', mode: 'ALL', key: 'zhuiyuezhutu'}
regions << {name: '依偎相守', mode: 'ALL', key: 'yiweixiangshou'}
regions << {name: '暖风春穗', mode: 'ALL', key: 'nuanfengchunhui'}
regions << {name: '樱之忆', mode: 'ALL', key: 'yingzhiyi'}
regions << {name: '鬼灯的冷彻', mode: 'ALL', key: 'guidengdelengche'}
regions << {name: '初心未改', mode: 'ALL', key: 'chuxinweigai'}
regions << {name: '狐之宴', mode: 'ALL', key: 'huzhiyan'}
regions << {name: '犬夜叉', mode: 'ALL', key: 'quanyecha'}
regions << {name: '立秋夕烛', mode: 'ALL', key: 'liqiuxizhu'}
regions << {name: '全球国际区', mode: 'ALL', key: 'quanqiuguojiqu'}
regions << {name: '枫之舞', mode: 'ALL', key: 'fengzhiwu'}
regions << {name: '雪之萤', mode: 'ALL', key: 'xuezhiying'}
regions << {name: '游梦迷蝶', mode: 'ALL', key: 'youmengmidie'}
regions << {name: '桃映春馨', mode: 'ALL', key: 'taoyingchunxin'}
regions << {name: '竹风夏意', mode: 'ALL', key: 'zhufengxiayi'}
regions << {name: '一叶禅心', mode: 'ALL', key: 'yiyechanxin'}
regions << {name: '夜火离歌', mode: 'ALL', key: 'yehuolige'}
regions << {name: '晴空日和', mode: 'ALL', key: 'qingkongrihe'}
regions << {name: '瀞灵廷', mode: 'ALL', key: 'jinglingting'}
regions << {name: '少时之约', mode: 'ALL', key: 'shaoshizhiyue'}
regions << {name: '鸣麓逐浪', mode: 'ALL', key: 'mingluzhulang'}
regions << {name: '八岐魅影', mode: 'ALL', key: 'baqimeiying'}
regions.each do |region|
  puts "...创建大区：#{region[:name]}"
  Region.create!(region)
end


end_time = Time.now
total_time = end_time - start_time

puts
puts 'done.' + '      total_time: ' + total_time.round(2).to_s + 's'


puts "...............清理无效的排行数据........start"
# 清理无效的排行数据
names_1 = IpNickName.pluck(:name).uniq
names_2 = Bloodline.pluck(:name).uniq

invalid_names = names_2 - names_1
invalid_names.each do |name|
  Bloodline.where(name: name).delete_all
end
puts "...............清理无效的排行数据......end..........."

# wget -O 217.mp4 https://yys.v.netease.com/2018/1204/1e2df8c8ee52c9c1fa0d9d13dac9093aqt.mp4
# wget -O 217-1.mp4 https://yys.v.netease.com/2018/1204/a8832f9744296697d781f0f976cc27b3qt.mp4
# wget -O 265.mp4 https://yys.v.netease.com/2018/1204/e40c844f1be81568746c14168234e1d2qt.mp4
# wget -O 265-1.mp4 https://yys.v.netease.com/2018/1204/ca5a0674eeac3db33acd72d41d29b3f8qt.mp4
# wget -O 266.mp4 https://yys.v.netease.com/2018/1204/85db18734e0ecc73148246c65ee73098qt.mp4
# wget -O 266-1.mp4 https://yys.v.netease.com/2018/1204/cf780e10240420c6495d14cd09714d97qt.mp4
# wget -O 255.mp4 https://yys.v.netease.com/2018/1204/f3ad5bce910bab4baef6de69b0da52f8qt.mp4
# wget -O 255-1.mp4 https://yys.v.netease.com/2018/1204/37c4629e3d1b53178a251aba4c401ae0qt.mp4
# wget -O 280.mp4 https://yys.v.netease.com/2018/1204/e318f540dec6c2dcf99944d391a9b580qt.mp4
# wget -O 280-1.mp4 https://yys.v.netease.com/2018/1204/b9c2ca200e0b98f4b5f32cf507ea30edqt.mp4
# wget -O 316.mp4 https://yys.v.netease.com/2018/1204/6ffb1b3a2c3bee7b26eef695e2b66350qt.mp4
# wget -O 311.mp4 https://yys.v.netease.com/2018/1204/a58f207feb8c170d66d87decdc7d0fc2qt.mp4
# wget -O 312.mp4 https://yys.v.netease.com/2018/1204/7c36f268939893c761bfc6c016c1463fqt.mp4
# wget -O 219.mp4 https://yys.v.netease.com/2018/1204/dd811b1ff035f6d57720c36c66f5bf1aqt.mp4
# wget -O 272.mp4 https://yys.v.netease.com/2018/1225/556149e381345e51981edc240bc7df1aqt.mp4
# wget -O 272-1.mp4 https://yys.v.netease.com/2018/1225/b3290dddd008370f014a73cfa85ac97cqt.mp4
# wget -O 325.mp4 https://yys.v.netease.com/2018/1225/a32a3c65aa3773ac33c5d81ae9a9563aqt.mp4
# wget -O 315.mp4 https://yys.v.netease.com/2019/0108/7ccf3c08be63b77345520edacee40a4dqt.mp4
# wget -O 304.mp4 https://yys.v.netease.com/2019/0122/ead14f06e1fc8d3b28ad3b44d5aa1b54qt.mp4
# wget -O 304-1.mp4 https://yys.v.netease.com/2019/0122/1ba17d581b9568db339f746f82597ec2qt.mp4
# wget -O 288.mp4 https://yys.v.netease.com/2019/0122/c8b7ea64e9f46b376aa4831a56d77e14qt.mp4
# wget -O 288-1.mp4 https://yys.v.netease.com/2019/0122/8323b1be3c8e0c554e833cd5b7e05edeqt.mp4
# wget -O 327.mp4 https://yys.v.netease.com/2019/0122/47ead38c8c8bcb12712b28c082e069caqt.mp4
# wget -O 326.mp4 https://yys.v.netease.com/2019/0122/71d5b75c04bb5fc0a6baf8972efdad52qt.mp4
# wget -O 269.mp4 https://yys.v.netease.com/2019/0129/9f4864dcdd9f1be6e067af7aafe86d48qt.mp4
# wget -O 322.mp4 https://yys.v.netease.com/2019/0312/03df1adf1d955ab9a7826881bc52b2c8qt.mp4
# wget -O 279.mp4 https://yys.v.netease.com/2019/0312/465e8ce8c962be3047eb2253f40b576aqt.mp4
# wget -O 279-1.mp4 https://yys.v.netease.com/2019/0312/b270a5c8e96c72694b87f64dbbdca90fqt.mp4
# wget -O 328.mp4 https://yys.v.netease.com/2019/0318/b0e20c94fef82226a00ba28227117555qt.mp4
# wget -O 296.mp4 https://yys.v.netease.com/2019/0318/669c047cafdced2365c4fef6af8c0b1fqt.mp4
# wget -O 248.mp4 https://yys.v.netease.com/2019/0401/746c5546002b92c5466e6a345d3baf1bqt.mp4
# wget -O 300.mp4 https://yys.v.netease.com/2019/0416/2699b066b9f71d3ed2e64cd6c548b48dqt.mp4
# wget -O 330.mp4 https://yys.v.netease.com/2019/0416/c4e1ea7fb756b44ce385779f33cabc3fqt.mp4
