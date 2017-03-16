class wls::java {
	exec { "download-wls" :
        cwd     => "/opt/oracle",
        command => "/usr/bin/wget --no-check-certificate --no-cookies --header \"Cookie: oraclelicense=accept-securebackup-cookie\" http://download.oracle.com/otn/nt/middleware/12c/12212/fmw_12.2.1.2.0_wls_Disk1_1of1.zip"
    }
	 exec { "unzip-wls" :
        cwd     => "/opt/oracle",
        command => "/opt/jdk1.8.0_112/bin/jar xvf fmw_12.2.1.2.0_wls_Disk1_1of1.zip && /usr/bin/rm –rf fmw_12.2.1.2.0_wls_Disk1_1of1.zip"
    }
	/* exec { "user-groupadd" :
        command => "groupadd -g 666 oinstall & useradd -u 666 -g oinstall -G oinstall oracle & passwd oracle"
    } */
 
	    # Set up some additional paths
    file { [
		"/opt/oracle",
        "/opt/oracle/inventory",
        "/opt/oracle/middleware"] :
        owner   => oracle,
        group   => oinstall,
        mode    => "755",
        ensure => "directory"
    }
	file { "/opt/oracle/oraInst.loc " :
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
        command => "/opt/jdk1.8.0_112/bin/java -jar fmw_12.2.1.2.0_wls.jar -silent -invPtrLoc /opt/oracle/oraInst.loc -responseFile /opt/oracle/Install.rsp -logfile /opt/oracle/wlsInstall.log"
    }
	exec { "create-domain" :

        command => "/opt/oracle/middleware/oracle_common/common/bin/wlst.sh /opt/oracle/createConfigDomain.py"
        
    }
	exec { "start-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/ctmdomain",
        command => "/usr/bin/sh startWeblogic.sh &"
        
    }

}

