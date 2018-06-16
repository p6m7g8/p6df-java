p6df::modules::java::version() { echo "0.0.1" }
p6df::modules::java::deps()    {
	ModuleDeps=()
}

p6df::modules::java::external::brew() {

  brew cask install $java_ver
  brew cask install $java_ver_dev
  brew cask install gradle
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
      p6dfz::util::path_if $JENV_ROOT/bin

     eval "$(jenv init - zsh)"
    fi
}

p6df::prompt::java::line() {

  env_version "j"
}
