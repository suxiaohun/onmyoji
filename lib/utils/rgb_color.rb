class RgbColor
  class << self

    def colors
      colors = []
      File.open("#{Rails.root.to_s}/lib/utils/rgb_color.txt").each_line do |line|
        colors << line.split
      end
      colors
    end


    def rand_color
      @rand_color = colors[rand(colors.length)][1]
    end
  end

end