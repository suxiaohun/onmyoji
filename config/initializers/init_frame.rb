require './lib/fwk/color'
require './lib/fwk/time_extend'
require './lib/utils/rgb_color'

String.send(:include, Fwk::Color)
ActiveSupport::TimeWithZone.send(:include, Fwk::TimeExtend)