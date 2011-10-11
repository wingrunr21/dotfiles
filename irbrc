require 'rubygems'
require 'yaml'
require 'rbconfig'
require 'paint'

alias q exit

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

if RbConfig::CONFIG['host_os'] =~ /mswin|mingw/
 require 'win32/console/ansi'
end

ANSI = {}
ANSI[:RESET]     = "\e[0m"
ANSI[:BOLD]      = "\e[1m"
ANSI[:UNDERLINE] = "\e[4m"
ANSI[:LGRAY]     = "\e[0;37m"
ANSI[:GRAY]      = "\e[1;30m"
ANSI[:RED]       = "\e[31m"
ANSI[:GREEN]     = "\e[32m"
ANSI[:YELLOW]    = "\e[33m"
ANSI[:BLUE]      = "\e[34m"
ANSI[:MAGENTA]   = "\e[35m"
ANSI[:CYAN]      = "\e[36m"
ANSI[:WHITE]     = "\e[37m"

# Build a simple colorful IRB prompt
IRB.conf[:PROMPT][:SIMPLE_COLOR] = {
  :PROMPT_I => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
  :PROMPT_N => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
  :PROMPT_C => "#{ANSI[:RED]}?>#{ANSI[:RESET]} ",
  :PROMPT_S => "#{ANSI[:YELLOW]}?>#{ANSI[:RESET]} ",
  :RETURN   => "#{ANSI[:GREEN]}=>#{ANSI[:RESET]} %s\n",
  :AUTO_INDENT => true }
IRB.conf[:PROMPT_MODE] = :SIMPLE_COLOR

# Loading extensions of the console. This is wrapped
# because some might not be included in your Gemfile
# and errors will be raised
def extend_console(name, care = true, required = true)
  if care
    require name if required
    yield if block_given?
    $console_extensions << "#{ANSI[:GREEN]}#{name}#{ANSI[:RESET]}"
  else
    $console_extensions << "#{ANSI[:GRAY]}#{name}#{ANSI[:RESET]}"
  end
rescue LoadError
  $console_extensions << "#{ANSI[:RED]}#{name}#{ANSI[:RESET]}"
end
$console_extensions = []

# Wirble is a gem that handles coloring the IRB
# output and history
extend_console 'wirble' do
  Wirble.init
  Wirble.colorize
end

# Hirb makes tables easy.
extend_console 'hirb' do
  Hirb.enable
  extend Hirb::Console
end

# awesome_print is prints prettier than pretty_print
extend_console 'ap' do
  alias pp ap
end

extend_console 'fancy_irb' do
  FancyIrb.start
end

# When you're using Rails 2 console, show queries in the console
extend_console 'rails2', (ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')), false do
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

# When you're using Rails 3 console, show queries in the console
extend_console 'rails3', defined?(ActiveSupport::Notifications), false do
  $odd_or_even_queries = false
  ActiveSupport::Notifications.subscribe('sql.active_record') do |*args|
    $odd_or_even_queries = !$odd_or_even_queries
    color = $odd_or_even_queries ? ANSI[:CYAN] : ANSI[:MAGENTA]
    event = ActiveSupport::Notifications::Event.new(*args)
    time  = "%.1fms" % event.duration
    name  = event.payload[:name]
    sql   = event.payload[:sql].gsub("\n", " ").squeeze(" ")
    puts "  #{ANSI[:UNDERLINE]}#{color}#{name} (#{time})#{ANSI[:RESET]}  #{sql}"
  end
end

# Add a method pm that shows every method on an object
# Pass a regex to filter these
extend_console 'pm', true, false do
  def pm(obj, *options) # Print methods
    methods = obj.methods
    methods -= Object.methods unless options.include? :more
    filter  = options.select {|opt| opt.kind_of? Regexp}.first
    methods = methods.select {|name| name =~ filter} if filter

    data = methods.sort.collect do |name|
      method = obj.method(name)
      if method.arity == 0
        args = "()"
      elsif method.arity > 0
        n = method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")})"
      elsif method.arity < 0
        n = -method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")}, ...)"
      end
      klass = $1 if method.inspect =~ /Method: (.*?)#/
      [name.to_s, args, klass]
    end
    max_name = data.collect {|item| item[0].size}.max
    max_args = data.collect {|item| item[1].size}.max
    data.each do |item|
      print " #{ANSI[:YELLOW]}#{item[0].to_s.rjust(max_name)}#{ANSI[:RESET]}"
      print "#{ANSI[:BLUE]}#{item[1].ljust(max_args)}#{ANSI[:RESET]}"
      print "   #{ANSI[:GRAY]}#{item[2]}#{ANSI[:RESET]}\n"
    end
    data.size
  end
end

extend_console 'interactive_editor' do
  # no configuration needed
end

# Show results of all extension-loading
puts "#{ANSI[:GRAY]}~> Console extensions:#{ANSI[:RESET]} #{$console_extensions.join(' ')}#{ANSI[:RESET]}"

# Helper methods
# From https://github.com/janlelis/irbtools/blob/master/lib/every_day_irb.rb

# shows the contents of your current directory (more such commands available by FileUtils)
def ls(path='.')
  Dir[ File.join( path, '*' )].map{|filename| File.basename filename }
end
alias dir ls

# read file contents (also see ray for ruby source files ;) )
def cat(path)
  File.read path
end

# allows concise syntax like rq:mathn and reloading/requiring
def rq(lib)
  require lib.to_s
end

# rerequire, not suited for non-rb, please note: can have non-intended side effects in rare cases
def rerequire(lib)
  $".dup.each{ |path|
    if path =~ %r</#{lib}\.rb$>
      $".delete path.to_s
      require path.to_s
    end
  }
  require lib.to_s
  true
end
alias rrq rerequire

# load shortcut, not suited for non-rb
def ld(lib)
  load lib.to_s + '.rb'
end

# returns the last lines, needed for some copy_ methods
def session_history(number_of_lines = nil)
  if !number_of_lines
    if defined?(Ripl) && Ripl.respond_to?(:started?) && Ripl.started?
      number_of_lines = Ripl.shell.line
    else
      number_of_lines = context.instance_variable_get(:@line_no)
    end
  end
  Readline::HISTORY.entries[-number_of_lines...-1]*"\n"
end

# restart irb
def reset!
  # remember history...
  reset_irb = proc{ exec$0 }
  if defined?(Ripl) && Ripl.respond_to?(:started?) && Ripl.started?
    Ripl.shell.write_history if Ripl.shell.respond_to? :write_history
    reset_irb.call
  else
    at_exit(&reset_irb)
    exit
  end
end

# just clear the screen
def clear
  system 'clear'
end

# load debugger, inspired by rdp
def dbg
  begin
    require 'ruby-debug'
    debugger
  rescue LoadError => err
    throw "Sorry, unable to load ruby-debug gem for debugger: #{err}"
  end
end
