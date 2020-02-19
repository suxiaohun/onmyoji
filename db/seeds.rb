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
