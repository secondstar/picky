require 'csv'
require 'sinatra/base'
require_relative '../lib/picky'

# ruby search_only.rb xxs (index size) 100 (amount of queries)
#
size   = ARGV[0].to_sym rescue puts("This script needs an index size as first argument.") && exit(1)
amount = ARGV[1] && ARGV[1].to_i || 10

data = Picky::Index.new size do
  category :text1
  category :text2
  category :text3
  category :text4
end

require_relative 'searches'

# You need to create the indexes first.
#
data.clear
data.load

require 'ruby-prof'
RubyProf.start
RubyProf.pause

# Run queries.
#
Searches.series_for(amount).each do |queries|

  queries.prepare

  run = Picky::Search.new data
  run.terminate_early
  
  queries.each do |query|
    RubyProf.resume
    run.search query
    RubyProf.pause
  end
  
end

result = RubyProf.stop

filename = "#{Dir.pwd}/20#{Time.now.strftime("%y%m%d%H%M")}-ruby-prof-results-#{size}-#{amount}.html"
File.open filename, 'w' do |file|
  RubyProf::GraphHtmlPrinter.new(result).print(file)
end

printer = RubyProf::GraphPrinter.new(result)
printer.print(STDOUT, :min_percent => 2)

command = "open #{filename}"
puts command
`#{command}`