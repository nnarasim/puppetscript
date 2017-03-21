class deploy::config {
	file { "/opt/oracle/createConfigDomain.py" :
        owner   => oracle,
        group   => oinstall,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/deploy/createConfigDomain.py"
    }
	file { " /opt/dell/pprc/auth/authmatrix.json" :
        owner   => oracle,
        group   => oinstall,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/deploy/authmatrix.json"
    }
	file { "/opt/dell/pprc/auth/techdirect.cer" :
        owner   => oracle,
        group   => oinstall,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/deploy/techdirect.cer"
    }
	exec { "create-domainConfig" :

        command => "/opt/oracle/middleware/oracle_common/common/bin/wlst.sh /opt/oracle/createConfigDomain.py"
        
    }
	exec { "clean-domainConfig" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/config-domain/autodeploy",
        command => "/usr/bin/rm -rf *"
        
    }	
	exec { "get-config_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/config-domain/autodeploy",
        command => "/usr/bin/wget http://192.168.0.100/config-microservice-1.0.0.war"
        
    }	
	exec { "get-discovery_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/config-domain/autodeploy",
        command => "/usr/bin/wget http://192.168.0.100/discovery-microservice-1.0.0.war"
        
    }	
	exec { "stop-config-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/config-domain/bin",
        command => "/usr/bin/sh startWeblogic.sh &"
        
    }
	exec { "start-config-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/config-domain",
        command => "/usr/bin/sh startWeblogic.sh &"
        
    }
}

class deploy::dmz {
	file { "/opt/oracle/createDMZDomain.py" :
        owner   => oracle,
        group   => oinstall,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/deploy/createDMZDomain.py"
    }
	exec { "create-domainDMZ" :

        command => "/opt/oracle/middleware/oracle_common/common/bin/wlst.sh /opt/oracle/createDMZDomain.py"
        
    }
	exec { "clean-domainDMZ" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/dmz-domain/autodeploy",
        command => "/usr/bin/rm -rf *"
        
    }
	exec { "get-auth_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/dmz-domain/autodeploy",
        command => "/usr/bin/wget http://192.168.0.100/auth-microservice-1.0.0.war"
        
    }	
	exec { "get-gateway_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/dmz-domain/autodeploy",
        command => "/usr/bin/wget http://192.168.0.100/gateway-microservice-1.0.0.war"
        
    }	
	exec { "stop-domainDMZ-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/dmz-domain/bin",
        command => "/usr/bin/sh startWeblogic.sh &"
        
    }
	exec { "start-domainDMZ-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/dmz-domain",
        command => "/usr/bin/sh startWeblogic.sh &"
        
    }
}

class deploy::functional {
	file { "/opt/oracle/createFunctionalDomain.py" :
        owner   => oracle,
        group   => oinstall,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/deploy/createFunctionalDomain.py"
    }
	exec { "create-domainFunctional" :

        command => "/opt/oracle/middleware/oracle_common/common/bin/wlst.sh /opt/oracle/createFunctionalDomain.py"
        
    }
	exec { "clean-domainFunctional" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/rm -rf *"
        
    }
	exec { "get-alerts_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/wget http://192.168.0.100/alerts-microservice-1.0.0.war"
        
    }	
	exec { "get-assets_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/wget http://192.168.0.100/assets-microservice-1.0.0.war"
        
    }	
	exec { "get-cases_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/wget http://192.168.0.100/cases-microservice-1.0.0.war"
        
    }	
	exec { "get-dispatch_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/wget http://192.168.0.100/dispatch-microservice-1.0.0.war"
        
    }	
	exec { "get-recommendation_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/wget http://192.168.0.100/recommendation-microservice-1.0.0.war"
        
    }	
	exec { "get-metrics_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/wget http://192.168.0.100/metrics-microservice-1.0.0.war"
        
    }	
	/*exec { "get-alerts_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/wget http://192.168.0.100/alerts-microservice-1.0.0.war"
        
    }	
	exec { "get-assets_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/wget http://192.168.0.100/assets-microservice-1.0.0.war"
        
    }	*/
	exec { "stop-domainDMZ-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/bin",
        command => "/usr/bin/sh startWeblogic.sh &"
        
    }
	exec { "start-domainDMZ-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain",
        command => "/usr/bin/sh startWeblogic.sh &"
        
    }

}
