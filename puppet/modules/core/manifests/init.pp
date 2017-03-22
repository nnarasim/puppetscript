class core::preinstall{

    exec { "rpm-update" :
        cwd     => "/etc/yum.repos.d",
        command => "/bin/rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org"
        
    }
	/*exec { "clear-epel" :
        cwd     => "/etc/yum.repos.d",
        command => "/bin/mv epel.repo epel.repo.bk"
        
    } */
	exec { "rpm-elrepo" :
        cwd     => "/etc/yum.repos.d",
        command => "/bin/rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm"
        
    }
	exec { "rpm-repo" :
        cwd     => "/etc/yum.repos.d",
        command => "/bin/curl --silent --location https://rpm.nodesource.com/setup_7.x | /bin/bash -"
        
    }
	
	exec { "yum-update" :
        cwd     => "/etc/yum.repos.d",
        command => "/usr/bin/yum update"
		}
	exec { "install-zip" :
        cwd     => "/etc/yum.repos.d",
        command => "/usr/bin/yum -y install zip"
		}
	exec { "install-unzip" :
        cwd     => "/etc/yum.repos.d",
        command => "/usr/bin/yum -y install unzip"
		}
	exec { "install-wget" :
        cwd     => "/etc/yum.repos.d",
        command => "/usr/bin/yum -y install wget"
		}
	exec { "Ruby-install" :
        cwd     => "/etc/yum.repos.d",
        command => "/usr/bin/yum -y install ruby"
	}
	exec { "Ruby-devel" :
        cwd     => "/opt",
        command => "/bin/rpm -Uvh ftp://195.220.108.108/linux/centos/7.3.1611/os/x86_64/Packages/ruby-devel-2.0.0.648-29.el7.x86_64.rpm"
	}
	
}
class core::install {

# Apache

    package { "httpd" :
        ensure => present
    }
	

    exec { "httpd-on-boot" :
        command  => "/sbin/chkconfig httpd on",
    }

  /*  file { "/etc/httpd/conf/httpd.conf" :
        owner   => root,
        group   => root,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/core/httpd.conf",
        require => Package["httpd"],
        before  => Service["httpd"]
    }
*/
    # Set up some additional paths
    file { [
        "/projects/content/",
        "/projects/content/common",
		"/projects/runtime",
		"/projects/local",
        "/projects/runtime/sessions" ] :
        owner   => root,
        group   => root,
        mode    => "755",
        ensure => "directory"
    }

# VHosts

    # add virtual host configs for our current site
   /* file { "/etc/httpd/conf.d/vhosts.conf" :
        owner   => root,
        group   => root,
        ensure  => file,
        mode    => "644",
        require => Package[ "httpd" ],
        content => template('core/vhosts.erb'),
        before  => Service["httpd"]
    } */

# Redirects

    # add a default "goredirects.txt" file (editable by WP)
    file { "/projects/content/common/goredirects.txt" :
        owner   => root,
        group   => root,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/core/goredirects.txt",
        before  => Service["httpd"]
    }

# SSL

  /*  package { "mod_ssl" :
        ensure => present
    }

    package { "openssl" :
        ensure => present,
        before => Exec["generate-SSL-key"]
    }

    exec { "generate-SSL-key" :
        cwd     => "/etc/pki/tls/private/",
        command => "/usr/bin/openssl genrsa -out microsite.local.key 1024",
        creates => "/etc/pki/tls/private/microsite.local.key",
        before  => Exec["generate-SSL-cert"]
    }

    exec { "generate-SSL-cert" :
        cwd      => "/etc/pki/tls/certs/",
        command  => "/usr/bin/openssl req -new -key /etc/pki/tls/private/microsite.local.key -x509 -subj '/O=Organization/OU=Organization/C=US/ST=New York/L=New York/CN=microsite.local' -out microsite.local.crt",
        creates  => "/etc/pki/tls/certs/microsite.local.crt"
    }
*/
    # Disable the _default_:443 virtualhost to stop conflicts when non-ssl and ssl hostnames are the same
   /* file { "/etc/httpd/conf.d/ssl.conf" :
        owner   => root,
        group   => root,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/core/ssl.conf",
        require => Package["mod_ssl"],
        before  => Service["httpd"]
    } */

# Start Services
   

    service { "httpd" :
        ensure  => running,
        require => [ Package[ "httpd" ] ]
    }


}
class core::java {
	exec { "download-java" :
        cwd     => "/opt",
        command => "/usr/bin/wget --no-check-certificate --no-cookies --header \"Cookie: oraclelicense=accept-securebackup-cookie\" http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.tar.gz"
        
    }
	 exec { "tar-java" :
        cwd     => "/opt",
        command => "/usr/bin/tar zxvf jdk-8u112-linux-x64.tar.gz"
        
    }
	 exec { "removeTar-java" :
        cwd     => "/opt",
        command => "/usr/bin/rm –rf jdk-8u112-linux-x64.tar.gz"
        
    }
	/*file { "/etc/profile.d/javahome.sh" :
        owner   => root,
        group   => root,
        ensure  => 'present',
        mode    => "644",
        source  => "puppet:///modules/core/javahome.sh
    }
	exec { "set-javahome" :
		cwd     => "/etc/profile.d",
        command => "/usr/bin/sh javahome.sh &"
        
    } */
	exec { "install-jce" :
        cwd     => "/opt",
        command => "/usr/bin/wget --no-check-certificate --no-cookies --header \"Cookie: oraclelicense=accept-securebackup-cookie\" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip"
        
    }
	 exec { "unzip-jce" :
        cwd     => "/opt",
        command => "/usr/bin/unzip jce_policy-8.zip"
        
    }
	 exec { "mv-jce" :
        cwd     => "/opt",
        command => "/usr/bin/mv -f UnlimitedJCEPolicyJDK8/* /opt/jdk1.8.0_112/jre/lib/security"
        
    }
	exec { "remove-zip-jce" :
        cwd     => "/opt",
        command => "/usr/bin/rm –rf jce_policy-8.zip"
        
    }
	 /* service { "iptables" :
        ensure  => stopped,
        require => [ Package[ "iptables" ] ]
    }
	  service { "ip6tables" :
        ensure  => stopped,
        require => [ Package[ "ip6tables" ] ]
    }
	exec { "iptables-off" :
        command  => "/sbin/chkconfig --level 35 iptables off",
    }
	exec { "ip6tables-off" :
        command  => "/sbin/chkconfig --level 35 ip6tables off",
    }
	*/

}
class core::config {


# Helpers

    # Some common aliases for use in vagrant ssh
    file { "/home/vagrant/.bashrc" :
        owner   => root,
        group   => root,
        ensure  => file,
        mode    => "644",
        content => template('core/vagrant_bashrc.erb')
    }

}


class core::restart {

    # Restart apache after config
    exec { "httpd-restart" :
        command  => "/usr/bin/sudo /sbin/service httpd restart",
    }
	/*exec { "stop-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/config-domain/bin",
        command => "/usr/bin/sh stopWebLogic.sh"
        
    }
	exec { "start-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/config-domain",
        command => "/usr/bin/sh startWebLogic.sh &"
        
    } */
}
