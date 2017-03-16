

class wls::java {
	exec { "download-wls" :
        cwd     => "/opt/oracle",
        command => "wget --no-check-certificate --no-cookies --header \" Cookie: oraclelicense=accept-securebackup-cookie \" http://download.oracle.com/otn/nt/middleware/12c/12212/fmw_12.2.1.2.0_wls_Disk1_1of1.zip ",
		mode => "755"
    }
	 exec { "unzip-wls" :
        cwd     => "/opt/oracle",
        command => "zip fmw_12.2.1.2.0_wls_Disk1_1of1.zip && rm –rf fmw_12.2.1.2.0_wls_Disk1_1of1.zip",
		mode => "755"
        
    }
	exec { "user-groupadd" :
        command => "groupadd -g 666 oinstall & useradd -u 666 -g oinstall -G oinstall oracle & passwd oracle"
    }
 
	    # Set up some additional paths
    file { [
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
		owner   => oracle,
        group   => oinstall,
        cwd     => "/opt/oracle",
        command => "java -jar fmw_12.2.1.2.0_wls.jar -silent -invPtrLoc /opt/oracle/oraInst.loc -responseFile /opt/oracle/Install.rsp -logfile /opt/oracle/wlsInstall.log",
		mode => "755" 
    }
	exec { "create-domain" :

        command => "/opt/oracle/middleware/oracle_common/common/bin/wlst.sh /opt/oracle/createConfigDomain.py"
        
    }
	exec { "start-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/ctmdomain",
        command => "./startWeblogic.sh &"
        
    }

}

