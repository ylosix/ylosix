stage { 'first':
    before => Stage['main'];
}

class prepare {
    class { 'apt':
      always_apt_update => true;

    }
    apt::ppa { 'ppa:chris-lea/node.js': }
}
class { 'prepare':
    stage => first;
}
include prepare

$sysPackages = ['git', 'curl', 'upstart', 'graphviz', 'tree', 'nodejs', 'imagemagick']
package { $sysPackages:
  ensure => "installed",
  require  => Class['prepare']
}

class { 'ruby':
  gems_version  => 'latest'
}

class install-rvm {
  include rvm
  rvm::system_user { 'vagrant': }

  rvm_system_ruby {
    'ruby-2.1.0':
      ensure      => 'present',
      default_use => true
  }

  rvm_gem {
    'ruby-2.1.0/bundler': ensure => '1.9.4';
  }

  rvm_gemset {
    'ruby-2.1.0@ecommerce':
      ensure  => present,
      require => Rvm_system_ruby['ruby-2.1.0']
  }
}
class {'install-rvm': }

#dump facts variables
file { "/home/vagrant/facts.yaml":
  content => inline_template("<%= scope.to_hash.reject { |k,v| !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>"),
}

