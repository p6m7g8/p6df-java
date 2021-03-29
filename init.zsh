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
    jdillon/mvnsh
    juven/maven-bash-completion
  )
}

######################################################################
#<
#
# Function: p6df::modules::java::vscodes()
#
#>
######################################################################
p6df::modules::java::vscodes() {

  # sonarlint
  code --install-extension SonarSource.sonarlint-vscode
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
#  Environment:	 P6_DFZ_SRC_P6M7G8_DIR
#>
######################################################################
p6df::modules::java::langs() {

  (
    cd /Library/Java/JavaVirtualMachines/
    for d in *; do
      (
        cd $d
        jenv add ./Contents/Home
      )
    done
  )
  jenv global 16
  jenv rehash

  curl -o $P6_DFZ_SRC_P6M7G8_DIR/p6df-java/share/apache-maven-3.6.3-bin.tar.gz https://mirrors.gigenet.com/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
  (cd $P6_DFZ_SRC_P6M7G8_DIR/p6df-java/share; tar -xvzf apache-maven-3.6.3-bin.tar.gz)
}

######################################################################
#<
#
# Function: p6df::modules::java::init()
#
#  Environment:	 P6_DFZ_SRC_DIR P6_DFZ_SRC_P6M7G8_DIR
#>
######################################################################
p6df::modules::java::init() {

  p6df::modules::java::jenv::init "$P6_DFZ_SRC_DIR"
  p6df::util::path_if "$P6_DFZ_SRC_P6M7G8_DIR/p6df-java/apache-maven-3.6.3/bin"
}

######################################################################
#<
#
# Function: p6df::modules::java::jenv::init(dir)
#
#  Args:
#	dir -
#
#  Depends:	 p6_echo
#  Environment:	 DISABLE_ENVS HAS_JAENV JENV_ROOT
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
#  Depends:	 p6_echo
#  Environment:	 JAVA_HOME JENV_ROOT
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
#  Depends:	 p6_lang
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
#  Depends:	 p6_lang
#>
######################################################################
p6_java_prompt_info() {

  echo -n "j:\t  "
  p6_lang_version "j"
}
