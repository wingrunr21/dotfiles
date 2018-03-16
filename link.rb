require 'fileutils'

FILES = %w[gemrc gitconfig gitignore_global irbrc zshrc zshenv zprofile zimrc zim zfunctions]
Dir.chdir(File.join(ENV['HOME'], 'dotfiles'))
FILES.each do |dotfile|
  FileUtils.ln_s File.join(Dir.pwd, dotfile), File.join(ENV['HOME'], ".#{dotfile}"), :force => true
end
