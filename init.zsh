p6df::modules::java::version() { echo "0.0.1" }
p6df::modules::java::deps()    { ModuleDeps=(gcuisinier/jenv) }

p6df::modules::java::brew() {

  brew cask install adoptopenjdk
  brew install maven
  brew install maven-completion
  brew install maven-shell
}

p6df::modules::java::langs() {

  jenv add /Library/Java/JavaVirtualMachines/*/Contents/Home/
  jenv global 13.0
  jenv rehash
}

p6df::modules::java::init() {

  p6df::modules::java::jenv::init "$P6_DFZ_SRC_DIR"
}

p6df::modules::java::jenv::init() {
  local dir="$1"

  [ -n "$DISABLE_ENVS" ] && return

  JENV_ROOT=$dir/gcuisinier/jenv

  if [ -x $JENV_ROOT/bin/jenv ]; then
    export JENV_ROOT
    export HAS_JAENV=1
    p6df::util::path_if $JENV_ROOT/bin

   eval "$(jenv init - zsh)"
  fi
}

p6df::prompt::java::line() {

  p6_lang_version "j"
}
