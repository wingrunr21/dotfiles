#
# User configuration sourced by interactive shells
#

# Prompt setup
BLOX_CONF__ONELINE=true
BLOX_CONF__NEWLINE=false
BLOX_CONF__BLOCK_PREFIX='('
BLOX_CONF__BLOCK_SUFFIX=')'
BLOX_SEG__UPPER_RIGHT=(blox_block__bgjobs blox_block__nodejs)
BLOX_BLOCK__CWD_TRUNC=0
BLOX_BLOCK__CWD_COLOR='green'

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

# Setup blox prompt
source ~/dotfiles/prompts/blox/blox.zsh
