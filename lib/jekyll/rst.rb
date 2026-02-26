require "jekyll"

root = File.expand_path('rst', File.dirname(__FILE__))
require "#{root}/filters"
require "#{root}/version"

require File.expand_path('rst', File.dirname(__FILE__))

module Jekyll
  module Rst
    module RestConverter
  end
  end
end
