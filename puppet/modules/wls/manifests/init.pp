class wls::java {

	group { 'oinstall':
		ensure => 'present',
		gid    => '666'
		}

	user { 'oracle':
		ensure => present,
		groups            => 'oinstall',
		gid             => '666',
        home             => '/home/oracle',
        password         => 'oracle',
        password_max_age => '99999',
        password_min_age => '0',
        shell            => '/bin/bash',
        uid              => '666'
	}
		    # Set up some additional paths
    file { [
		"/opt/oracle",
        "/opt/oracle/inventory",
        "/opt/oracle/middleware",
		"/opt/dell/pprc",
		"/opt/dell/pprc/auth"] :
        owner   => oracle,
        group   => oinstall,
        mode    => "755",
        ensure => "directory"
    }
	/*exec { "download-wls" :
        cwd     => "/opt/oracle",
        command => "/usr/bin/wget --no-check-certificate --no-cookies --header \"Cookie: oraclelicense=accept-securebackup-cookie\" http://download.oracle.com/otn/nt/middleware/12c/12212/fmw_12.2.1.2.0_wls_Disk1_1of1.zip"
    } */
		exec { "download-wls" :
        cwd     => "/opt/oracle",
        command => "/usr/bin/wget http://172.20.49.153/fmw_12.2.1.2.0_wls_Disk1_1of1.zip"
    }
	 exec { "unzip-wls" :
        cwd     => "/opt/oracle",
        command => "/usr/bin/unzip -q fmw_12.2.1.2.0_wls_Disk1_1of1.zip"
    }
	 exec { "remove-zip-wls" :
        cwd     => "/opt/oracle",
        command => "/usr/bin/rm –rf fmw_12.2.1.2.0_wls_Disk1_1of1.zip"
    }
	/* exec { "user-groupadd" :
        command => "groupadd -g 666 oinstall & useradd -u 666 -g oinstall -G oinstall oracle & passwd oracle"
    } */
 

	file { "/opt/oracle/oraInst.loc" :
        owner   => oracle,
        group   => oinstall,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/wls/oraInst.loc"
    }
    file { "/opt/oracle/Install.rsp" :
        owner   => oracle,
        group   => oinstall,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/wls/Install.rsp"
    }
	file { "/opt/oracle/createConfigDomain.py" :
        owner   => oracle,
        group   => oinstall,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/wls/createConfigDomain.py"
    }

	exec { "install-wls" :
		user   => oracle,
        group   => oinstall,
        cwd     => "/opt/oracle",
        command => "/opt/jdk1.8.0_112/bin/java -jar fmw_12.2.1.2.0_wls_quick.jar -silent -invPtrLoc /opt/oracle/oraInst.loc -responseFile /opt/oracle/Install.rsp -logfile /opt/oracle/wlsInstall.log"
    }
	exec { "create-domain" :

        command => "/opt/oracle/middleware/oracle_common/common/bin/wlst.sh /opt/oracle/createConfigDomain.py"
        
    }
	exec { "start-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/config-domain",
        command => "/usr/bin/sh startWeblogic.sh &"
        
    }

}

