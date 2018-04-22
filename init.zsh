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

}
p6df::modules::java::init
