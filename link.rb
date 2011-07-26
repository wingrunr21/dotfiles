require 'fileutils'

Dir.chdir(File.join(ENV['HOME'], 'dotfiles'))
Dir.glob("*").each do |dotfile|
  FileUtils.ln_s File.join(Dir.pwd, dotfile), File.join(ENV['HOME'], ".#{dotfile}"), :force => true
end