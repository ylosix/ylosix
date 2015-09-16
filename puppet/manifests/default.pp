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

$sysPackages = ['git', 'curl', 'libpq-dev', 'upstart', 'graphviz', 'tree', 'nodejs', 'imagemagick']
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
    'ruby-2.1.6':
      ensure      => 'present',
      default_use => true
  }

  rvm_gem {
    'ruby-2.1.6/bundler': ensure => '1.9.4';
  }

  rvm_gemset {
    'ruby-2.1.6@ecommerce':
      ensure  => present,
      require => Rvm_system_ruby['ruby-2.1.6']
  }
}
class {'install-rvm': }


class { 'postgresql::server':
  ip_mask_allow_all_users    => '0.0.0.0/0',
  listen_addresses           => '*',
  postgres_password          => 'postgres'
}

postgresql::server::db { 'ecommerce':
  user     => 'ecommerce_user',
  password => postgresql_password('ecommerce_user', 'ecommerce_pass')
}

postgresql::server::role { "ecommerce_user":
  password_hash => postgresql_password('ecommerce_user', 'ecommerce_pass'),
  superuser => true
}

#dump facts variables
file { "/home/vagrant/facts.yaml":
  content => inline_template("<%= scope.to_hash.reject { |k,v| !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>"),
}

