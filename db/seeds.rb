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


# init yys data
ShiShen.delete_all
# SSR
shi_shens = []
shi_shens << {name: '泷夜叉姬', mode: 'SSR', sid: '338'}
shi_shens << {name: '黑崎一护', mode: 'SSR', sid: '337'}
shi_shens << {name: '大岳丸', mode: 'SSR', sid: '333'}
shi_shens << {name: '不知火', mode: 'SSR', sid: '330'}
shi_shens << {name: '八岐大蛇', mode: 'SSR', sid: '325'}
shi_shens << {name: '桔梗', mode: 'SSR', sid: '319'}
shi_shens << {name: '白藏主', mode: 'SSR', sid: '316'}
shi_shens << {name: '杀生丸', mode: 'SSR', sid: '314'}
shi_shens << {name: '犬夜叉', mode: 'SSR', sid: '313'}
shi_shens << {name: '鬼切', mode: 'SSR', sid: '312'}
shi_shens << {name: '面灵气', mode: 'SSR', sid: '311'}
shi_shens << {name: '鬼灯', mode: 'SSR', sid: '308'}
shi_shens << {name: '卖药郎', mode: 'SSR', sid: '305'}
shi_shens << {name: '御馔津', mode: 'SSR', sid: '304'}
shi_shens << {name: '玉藻前', mode: 'SSR', sid: '300'}
shi_shens << {name: '山风', mode: 'SSR', sid: '296'}
shi_shens << {name: '奴良陆生', mode: 'SSR', sid: '294'}
shi_shens << {name: '雪童子', mode: 'SSR', sid: '292'}
shi_shens << {name: '彼岸花', mode: 'SSR', sid: '288'}
shi_shens << {name: '荒', mode: 'SSR', sid: '283'}
shi_shens << {name: '辉夜姬', mode: 'SSR', sid: '280'}
shi_shens << {name: '花鸟卷', mode: 'SSR', sid: '279'}
shi_shens << {name: '一目连', mode: 'SSR', sid: '272'}
shi_shens << {name: '妖刀姬', mode: 'SSR', sid: '269'}
shi_shens << {name: '青行灯', mode: 'SSR', sid: '266'}
shi_shens << {name: '茨木童子', mode: 'SSR', sid: '265'}
shi_shens << {name: '小鹿男', mode: 'SSR', sid: '259'}
shi_shens << {name: '阎魔', mode: 'SSR', sid: '255'}
shi_shens << {name: '荒川之主', mode: 'SSR', sid: '248'}
shi_shens << {name: '酒吞童子', mode: 'SSR', sid: '219'}
shi_shens << {name: '大天狗', mode: 'SSR', sid: '217'}

# SP
shi_shens << {name: '烬天玉藻前', mode: 'SP', sid: '339'}
shi_shens << {name: '骁浪荒川之主', mode: 'SP', sid: '334'}
shi_shens << {name: '御怨般若', mode: 'SP', sid: '331'}
shi_shens << {name: '赤影妖刀姬', mode: 'SP', sid: '328'}
shi_shens << {name: '苍风一目连', mode: 'SP', sid: '327'}
shi_shens << {name: '稻荷神御馔津', mode: 'SP', sid: '326'}
shi_shens << {name: '炼狱茨木童子', mode: 'SP', sid: '322'}
shi_shens << {name: '少羽大天狗', mode: 'SP', sid: '315'}


shi_shens.each do |ss|
  puts "...创建式神：#{ss[:name]}"
  ShiShen.create!(ss)
end


# test data
# Piece.create({sid: '339', count: 30})


end_time = Time.now
total_time = end_time - start_time

puts
puts 'done.' + '      total_time: ' + total_time.round(2).to_s + 's'