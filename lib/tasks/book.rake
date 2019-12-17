namespace :book do
  desc "init the books"
  task init: :environment do
    Author.delete_all
    author_array = [{name: '佚名'},
                    {name: '默默猴'},
                    {name: '血红'},
                    {name: 'lido'},
                    {name: '冰山男子'},
                    {name: '玄雨'},
                    {name: '李鸿天'},
                    {name: 'zhttty'},
                    {name: '苏小魂'}]

    @authors = Author.create(author_array).inject({}) { |r, x| r[x.id] = x.name; r }

    def self.get_author(name)
      @authors.key(name) || @authors.key('佚名')
    end


    def get_pre_content(path)
      pre_content = '......'
      begin
        File.open(path) do |io|
          pre_content = io.gets.chomp
          10.times { |x| pre_content += io.gets.chomp }
        end
      rescue => e
        puts e.message
      end
      pre_content
    end

    Category.delete_all
    category_array = [
        {name: '玄幻'},
        {name: '科幻'},
        {name: '武侠'},
        {name: '名著'},
        {name: '异能'},
        {name: '都市'},
        {name: '异界'},
        {name: '无限流'},
        {name: '架空'}
    ]

    categories = Category.create(category_array).inject({}) { |r, x| r[x.id] = x.name; r }

    Book.delete_all

    puts '    start create books...'

    book_array = [
        # {
        #     name: '墨邪录',
        #     display_name: '墨邪录',
        #     author_id: get_author('苏小魂'),
        #     tag: '玄幻|修真|异界|神话',
        #     category_id: categories.key('玄幻'),
        #     path: 'public/books/yaodaoji.txt'
        # },
        {
            name: '无限恐怖',
            display_name: '无限恐怖',
            author_id: get_author('默默猴'),
            tag: '无限流|轮回',
            category_id: categories.key('无限流'),
            path: 'public/books/wuxiankongbu.txt'
        },
        # {
        #     name: '妖刀记',
        #     display_name: '【妖刀记】【1-50卷（第一部）完结】',
        #     author_id: get_author('默默猴'),
        #     tag: '武侠',
        #     category_id: categories.key('武侠'),
        #     path: 'public/books/yaodaoji.txt'
        # },
        # {
        #     name: '照日天劫',
        #     display_name: '照日天劫',
        #     author_id: get_author('默默猴'),
        #     tag: '武侠',
        #     category_id: categories.key('武侠'),
        #     path: 'public/books/zhaoritianjie.txt'
        # },
        # {
        #     name: '回归战队',
        #     display_name: '回归战队',
        #     author_id: get_author('默默猴'),
        #     tag: '都市|机甲',
        #     category_id: categories.key('都市'),
        #     path: 'public/books/huiguizhandui.txt'
        # },
        {
            name: '升龙道',
            display_name: '升龙道',
            author_id: get_author('血红'),
            tag: '都市|玄幻',
            category_id: categories.key('玄幻'),
            path: 'public/books/shenglongdao.txt'
        },
        {
            name: '逆龙道',
            display_name: '逆龙道',
            author_id: get_author('血红'),
            tag: '都市|玄幻',
            category_id: categories.key('玄幻'),
            path: 'public/books/nilongdao.txt'
        },
        {
            name: '征神领域',
            display_name: '征神领域',
            author_id: get_author('冰山男子'),
            tag: '都市|异能',
            category_id: categories.key('异能'),
            path: 'public/books/zhengshenlingyu.txt'
        },
        {
            name: '小兵传奇',
            display_name: '小兵传奇',
            author_id: get_author('玄雨'),
            tag: '未来|科幻|舰队',
            category_id: categories.key('科幻'),
            path: 'public/books/xiaobingchuanqi.txt'
        },
        {
            name: 'emofaze',
            display_name: '恶魔法则',
            author_id: get_author('跳舞'),
            tag: '玄幻|架空',
            category_id: categories.key('玄幻'),
            path: 'public/books/emofaze.txt'
        },
        {
            name: 'jiuzhoupiaomiaolu',
            display_name: '幻城',
            author_id: get_author('/'),
            tag: '玄幻|架空',
            category_id: categories.key('玄幻'),
            path: 'public/books/jiuzhoupiaomiaolu.txt'
        },
        {
            name: 'langqun',
            display_name: '狼群',
            author_id: get_author('/'),
            tag: '军事|雇佣兵',
            category_id: categories.key('都市'),
            path: 'public/books/langqun.txt'
        },
        # {
        #     name: '异世界的美食家',
        #     display_name: '异世界的美食家',
        #     author_id: get_author('李鸿天'),
        #     tag: '异界|厨神|修真',
        #     category_id: categories.key('玄幻'),
        #     path: 'public/books/yishijiedemeishijia.txt'
        # }
    ]
    books = Book.create(book_array)

    puts '    start init books pre content...'

    books.each do |book|
      puts "....book_name: #{book.display_name}"
      book.pre_content = get_pre_content(book.path)
      book.save!
    end
  end

end
