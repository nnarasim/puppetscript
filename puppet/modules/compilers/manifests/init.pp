class compilers::grunt {

    # NodeJS
    package { "nodejs" :
        ensure => installed,
    }

    exec { "npm-update" :
        user    => root,
        group   => root,
        command => "/usr/bin/npm update npm -g",
		before => Exec["grunt-cli"]
    }

    exec { "grunt-cli" :
        user    => root,
        group   => root,
        command => "/usr/bin/npm install -g grunt-cli",
        creates => "/usr/bin/grunt",
        before  => Exec["install-grunt"]
    }

    exec { "install-grunt" :
        user    => root,
        group   => root,
        cwd     => "/projects/local",
        command => "/usr/bin/npm install",
        before  => Exec["start-grunt"]
    }

    exec { "start-grunt" :
        user    => root,
        group   => root,
        cwd     => "/projects/local",
        command => "/usr/bin/grunt watch &" # background job
    }

}

class compilers::sass {

    exec { "install-compass" :
        user    => root,
        group   => root,
        command => "/usr/bin/gem install compass",
        creates => "/usr/bin/compass",
        before => Exec["compass-watch"]
    }

    exec { "compass-permissions" :
        user    => root,
        group   => root,
        command => "/bin/chmod +x /projects/local/puppetscript/puppet/modules/compilers/files/compile_sass.sh",
        before => Exec["compass-watch"]
    }

    exec { "compass-watch" :
        user    => root,
        group   => root,
        cwd     => "/projects/local/compass",
        command => "/projects/local/puppetscript/puppet/modules/compilers/files/compile_sass.sh start"
    }

}

class compilers::composer {

    package { "git" :
        ensure => installed
    }

    exec { "install-composer" :
        user    => root,
        group   => root,
        cwd     => "/projects/local",
        command => "/usr/bin/curl -sS https://getcomposer.org/installer | /usr/bin/php",
        creates => "/projects/local/composer.phar",
        require => [Package[ "git" ] ],
        before => Exec["move-composer"]
    }

    exec { "move-composer" :
        user    => root,
        group   => root,
        cwd     => "/projects/local",
        command => "/bin/mv composer.phar /usr/bin/composer",
        creates => "/usr/bin/composer",
        require => Exec["install-composer"],
        before => Exec["run-composer"]
    }

    # Run composer if a composer.json is found
    exec { "run-composer" :
        timeout     => 360,
        onlyif      => "/usr/bin/test -e /projects/local/wp-content/composer.json",
        cwd         => "/projects/local/wp-content",
        environment => "COMPOSER_HOME=/projects/local",
        command     => "/usr/bin/composer install",
        require     => Exec["move-composer"]
    }
}
