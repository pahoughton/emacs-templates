# dependancies
class emacs-utils {
  case $::osfamily {
    'Darwin' : {
      $provider = macports,
    }
    default : {
      $provider = undef,
    }
  }
  package { ['emacs','ispell'] :
    ensure  => 'installed'
    provider  => $provider
  }
}
