
######################################################################
#<
#
# Function: p6df::modules::java::deps()
#
#>
######################################################################
p6df::modules::java::deps() {
  ModuleDeps=(
    p6m7g8/p6common
    gcuisinier/jenv
  )
}

######################################################################
#<
#
# Function: p6df::modules::java::brew()
#
#>
######################################################################
p6df::modules::java::brew() {

  brew tap adoptopenjdk/openjdk
  brew cask install adoptopenjdk
  brew install maven
  brew install maven-completion
  brew install maven-shell
}

######################################################################
#<
#
# Function: p6df::modules::java::langs()
#
#>
######################################################################
p6df::modules::java::langs() {

  jenv add /Library/Java/JavaVirtualMachines/*/Contents/Home/
  jenv global 13.0
  jenv rehash
}

######################################################################
#<
#
# Function: p6df::modules::java::init()
#
#>
######################################################################
p6df::modules::java::init() {

  p6df::modules::java::jenv::init "$P6_DFZ_SRC_DIR"
}

######################################################################
#<
#
# Function: p6df::modules::java::jenv::init(dir)
#
#  Args:
#	dir -
#
#>
######################################################################
p6df::modules::java::jenv::init() {
  local dir="$1"

  [ -n "$DISABLE_ENVS" ] && return

  JENV_ROOT=$dir/gcuisinier/jenv

  if [ -x $JENV_ROOT/bin/jenv ]; then
    export JENV_ROOT
    export HAS_JAENV=1
    p6df::util::path_if $JENV_ROOT/bin

    eval "$(p6_run_code jenv init - zsh)"
  fi
}

######################################################################
#<
#
# Function: p6df::modules::java::prompt::line()
#
#>
######################################################################
p6df::modules::java::prompt::line() {

  p6_java_prompt_info
}

######################################################################
#<
#
# Function: p6_java_prompt_info()
#
#>
######################################################################
p6_java_prompt_info() {

  echo -n "j:\t  "
  p6_lang_version "j"
}