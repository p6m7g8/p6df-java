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
  local ver
  for ver in 8 9 10 11 12 13 14 15 16; do
    brew install --cask adoptopenjdk/openjdk/adoptopenjdk${ver}
  done
}

######################################################################
#<
#
# Function: p6df::modules::java::langs()
#
#>
######################################################################
p6df::modules::java::langs() {

  (
    cd /Library/Java/JavaVirtualMachines/
    for d in *; do 
      (cd $d; jenv add ./Contents/Home)
     done
  )
  jenv global 16.0
  jenv rehash

# XXX: These use the base brew java
#  brew install maven
#  brew install maven-completion
#  brew install maven-shell
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
# Function: p6df::modules::java::jenv::prompt::line()
#
#>
######################################################################
p6df::modules::java::jenv::prompt::line() {

  p6_echo "jenv:\t  jenv_root=$JENV_ROOT
jenv:\t  java_home=$JAVA_HOME"
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
