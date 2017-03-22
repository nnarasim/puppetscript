class deploy::config {
	file { "/opt/oracle/createConfigDomain.py" :
        owner   => oracle,
        group   => oinstall,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/deploy/createConfigDomain.py"
    }
	  file { ["/opt/dell/pprc/config-repo"] :
        owner   => oracle,
        group   => oinstall,
        mode    => "755",
        ensure => "directory"
    }
	file { "/opt/dell/pprc/auth/authmatrix.json" :
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
	file { "/opt/dell/pprc/config-repo/application.yml" :
        owner   => oracle,
        group   => oinstall,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/deploy/application.yml"
    }
	file { "/opt/dell/pprc/config-repo/gateway.yml" :
        owner   => oracle,
        group   => oinstall,
        ensure  => file,
        mode    => "644",
        source  => "puppet:///modules/deploy/gateway.yml"
    }
	exec { "git-init" :
        cwd     => "/opt/dell/pprc/config-repo",
        command => "/usr/bin/git init"
        
    }
	exec { "git-add" :
        cwd     => "/opt/dell/pprc/config-repo",
        command => "/usr/bin/git add --all"
        
    }
	exec { "git-commit" :
        cwd     => "/opt/dell/pprc/config-repo",
        command => "/usr/bin/git commit -m \"Intial version\""
        
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
        command => "/usr/bin/wget http://172.20.49.153/config-microservice-1.0.0.war"
        
    }	
	exec { "get-discovery_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/config-domain/autodeploy",
        command => "/usr/bin/wget http://172.20.49.153/discovery-microservice-1.0.0.war"
        
    }	
	exec { "stop-config-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/config-domain/bin",
        command => "/usr/bin/sh stopWebLogic.sh"
        
    }
	exec { "start-config-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/config-domain",
        command => "/usr/bin/sh startWebLogic.sh &"
        
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
        command => "/usr/bin/wget http://172.20.49.153/auth-microservice-1.0.0.war"
        
    }	
	exec { "get-gateway_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/dmz-domain/autodeploy",
        command => "/usr/bin/wget http://172.20.49.153/gateway-microservice-1.0.0.war"
        
    }	
	exec { "stop-domainDMZ-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/dmz-domain/bin",
        command => "/usr/bin/sh stopWebLogic.sh"
        
    }
	exec { "start-domainDMZ-wls" :
		timeout     => 660,
		cwd     => "/opt/oracle/middleware/user_projects/domains/dmz-domain",
        command => "/usr/bin/sh startWebLogic.sh &"
        
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
        command => "/usr/bin/wget http://172.20.49.153/alerts-microservice-1.0.0.war"
        
    }	
	exec { "get-assets_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/wget http://172.20.49.153/assets-microservice-1.0.0.war"
        
    }	
	exec { "get-cases_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/wget http://172.20.49.153/cases-microservice-1.0.0.war"
        
    }	
	exec { "get-dispatch_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/wget http://172.20.49.153/dispatch-microservice-1.0.0.war"
        
    }	
	exec { "get-recommendation_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/wget http://172.20.49.153/recommendation-microservice-1.0.0.war"
        
    }	
	exec { "get-metrics_war" :
        cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/autodeploy",
        command => "/usr/bin/wget http://172.20.49.153/metrics-microservice-1.0.0.war"
        
    }	

	exec { "stop-domainFunctional-wls" :
		cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain/bin",
        command => "/usr/bin/sh stopWebLogic.sh"
        
    }
	exec { "start-domainFunctional-wls" 
		user   => root,
        group   => root,
		cwd     => "/opt/oracle/middleware/user_projects/domains/functional-domain",
        command => "/usr/bin/sh startWebLogic.sh &"
        
    }

}
