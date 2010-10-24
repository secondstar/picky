$KCODE = 'UTF-8' unless RUBY_VERSION > '1.8.7'

require 'rubygems'

# require 'active_support'
require 'yajl'

dir = File.dirname __FILE__
require File.expand_path('picky-client/engine', dir)
require File.expand_path('picky-client/convenience', dir)
require File.expand_path('picky-client/helper', dir)
require File.expand_path('picky-client/generator', dir)