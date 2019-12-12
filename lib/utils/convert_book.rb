require 'ruby-pinyin'
require 'fileutils'
class ConvertBook
  class << self

    # 将目录下的所有txt文件，全部遍历，转码成utf8，并生成一份新的utf8编码的文件
    def convert
      error_files = []
      count = 0
      FileUtils.rm_rf('backup')
      Dir.glob(["**/*.txt", "**/*.TXT"]).each do |file_name|
        count+=1
        dirname = File.dirname("backup/#{file_name}")
        unless File.directory?(dirname)
          FileUtils.mkdir_p(dirname)
        end

        begin
          next if File.zero?(file_name)
          File.open(file_name) do |input|
            File.open("backup/#{file_name}", 'w') do |output|
              content = input.read
              unless content.valid_encoding?
                content.force_encoding('GB18030')
              end
              output.write(content.encode('UTF-8'))
            end
          end
          puts "\e[32mconverting: #{file_name}\e[0m"
        rescue
          error_files << file_name
          # remove this error file
          File.unlink(file_name)
          puts "\e[31m----无法解析文件编码，请手动转码-----------#{file_name}----------------\e[0m"
        end
      end
      puts "........共计#{count}本"
    end


    # 验证转码后的文件是否正确转成了utf8
    def verify

      count = 0
      error_valid_files = []
      Dir.glob(["backup/**/*.txt", "backup/**/*.TXT"]).each do |file_name|
        count += 1
        File.open(file_name) do |io|
          str = ''
          10.times do
            str += (io.gets || '')
          end
          str = str.gsub(/(\s|[-=━])+/, "")[0, 30]

          if str.to_s =~ /(\p{Han}|[A-Za-z0-9])+/
            puts "\e[32m----#{count.to_s}---验证通过-----------#{file_name}----#{str}------------\e[0m"
          else
            error_msg = "\e[31m----#{count.to_s}---验证失败-----------#{file_name}----#{str}------------\e[0m"
            error_valid_files << error_msg
            puts error_msg
          end
        end
      end
      error_valid_files.each(&method(:puts))
      puts "........共计#{count}本"
    end
  end
end
#
#

#
#
# # todo 将文档名由中文变成英文，并生成一份新的文档作为备份
#
#
# # Dir.glob("**/*.txt").each do  |file_name|
# #
# #
# #
# #
# # 文件encoding并不影响文件的输入和输出，io.gets会原封不动的将文本内容取出，即使是错误的编码
# # 可以使用valid_encoding?判断内容是否是正确的编码（符合系统环境的默认编码（utf8））
# # 如果是错误编码，可以将内容强制转码（str.f
# # orce_encoding('GB18030')），之后使用utf8解析
# #
# #
# #
# # 遍历目录，输出所有txt文件的名称
#   Dir.glob("*.txt").each(&method(:puts))
# # if str.to_s =~ /\p{Han}/
# #   puts str
# # else
# # str.force_encoding('GB18030')
# # puts str.encode('UTF-8')
# # end
#
# # "r:UTF-8",&:read
# # 遍历目录，输出所有txt文件的encoding
#
#   count = 0
#   Dir.glob("**/*.txt").each do |file_name|
#     count += 1
#     puts "------------------" + count.to_s
#     File.open(file_name) do |io|
#       str = ''
#       5.times do
#         str += io.gets
#       end
#
#       if str.valid_encoding?
#         puts str
#       else
#         str.force_encoding('GB18030')
#         puts str.encode('UTF-8')
#       end
#     end
#   end
#
#
#   count = 0
#   Dir.glob("**/*.txt").each do |file_name|
#     count += 1
#     puts "------------------" + count.to_s
#     File.open(file_name) do |io|
#       str = ''
#       5.times do
#         str += io.gets
#       end
#       if str.valid_encoding?
#         puts str.encode('UTF-8')
#       else
#         str.force_encoding('GB18030')
#         puts str.encode('UTF-8')
#       end
#     end
#   end
#
#
#   count = 0
#   Dir.glob("backup/*.txt").each do |file_name|
#     count += 1
#     File.open(file_name) do |io|
#       str = ''
#       5.times do
#         str += io.gets
#       end
#       puts str
#     end
#     puts "------------------" + count.to_s + '------------------------------'
#   end
#
#
# # 打开文件，判断文件的encoding
#   File.open('1.txt') do |io|
#     p io.external_encoding
#     p io.internal_encoding
#   end
#
#
# #
# # todo 将文档按照章节拆分？
#
#   Dir.glob("**/*.txt").each do |file_name|
#
#     puts file_name
#
#   end
#
#
#   require 'ruby-pinyin'
#   require 'fileutils'
#   Dir.glob("*.txt").each do |file_name|
#     Dir.mkdir('backup') unless Dir.exist?('backup')
#     puts file_name
#     origin_file_name = file_name.split('.')[0]
#     en_file_name = PinYin.of_string(origin_file_name).join
#     FileUtils.cp(file_name, "backup/#{en_file_name}.txt")
#   end
#
#
# =begin
#   require 'ruby-pinyin'
#   Dir.glob("**/*.txt").each do |file_name|
#     Dir.mkdir('backup') unless Dir.exist?('backup')
#     origin_file_name = file_name.split('.')[0]
#     en_file_name = PinYin.of_string(origin_file_name).join
#
#     File.open(file_name) do |input|
#       File.open("backup/#{en_file_name}.txt",'w') do |output|
#         content = input.read
#         unless content.valid_encoding?
#           content.force_encoding('GB18030')
#         end
#         output.write(content.encode('UTF-8'))
#       end
#     end
#   end
# =end
#
#
#
#
#
#   # todo 将正确编码的文件，按照修正后的中文名称，生成对应的英文名称文件
#
#   book = Spreadsheet.open('1.xls')
#   book.sheet
#
