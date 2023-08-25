# Based mostly on fino-time and gnzh theme

setopt prompt_subst

() {

local PR_USER PR_USER_OP PR_PROMPT PR_HOST

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER='%{$FG[040]%}%n%f'
  PR_USER_OP='%{$FG[040]%}%#%f'
  PR_PROMPT='%f➤ %f'
else # root
  PR_USER='%{$FG[160]%}%n%f'
  PR_USER_OP='%{$FG[160]%}%#%f'
  PR_PROMPT='%{$FG[160]%}➤ %f'
fi

function box_name {
  local box="${SHORT_HOST:-$HOST}"
  [[ -f ~/.box-name ]] && box="$(< ~/.box-name)"
  echo "${box:gs/%/%%}"
}

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%{$FG[165]%}$(box_name)%f' # SSH
else
  PR_HOST='%{$FG[033]%}$(box_name)%f' # no SSH
fi


local return_code="%(?..%{$FG[160]%}%? ↵%f)"

local user_host="${PR_USER} %{$FG[239]%}at%{$reset_color%} ${PR_HOST}"
local current_dir="%{$FG[226]%}%~%f"
local git_branch='$(git_prompt_info)'
local git_sha='$(git_prompt_short_sha)'

PROMPT="╭─(%B%{$FG[125]%}%D - %*%f%b)  ${user_host} %{$FG[239]%}in%{$reset_color%} ${current_dir}\$(ruby_prompt_info)${git_sha}${git_branch}
╰─$PR_PROMPT"
RPROMPT="${return_code}"

ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$FG[239]%}on%{$reset_color%} %{$FG[051]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%f%b"

ZSH_THEME_GIT_PROMPT_PREFIX=" %B%{$FG[125]%}\uE0A0%b %{$FG[051]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[160]%} ✘"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[040]%} ✔"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f%b"
ZSH_THEME_RUBY_PROMPT_PREFIX="%{$FG[160]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%f"

}
