require './lib/fwk/color'
require './lib/fwk/time_extend'

String.send(:include, Fwk::Color)
ActiveSupport::TimeWithZone.send(:include, Fwk::TimeExtend)