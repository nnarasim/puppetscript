class redis::install {

	exec { "install-redis" :
		user   => root,
        group   => root,
        cwd     => "/opt/oracle",
        command => "/usr/bin/yum -y install redis"
    }
	exec { "redis-enable" :
		user   => root,
        group   => root,
        cwd     => "/opt/oracle",
        command => "/usr/bin/systemctl enable redis.service"
    }
	exec { "redis-sentinnel-enable" :
		user   => root,
        group   => root,
        cwd     => "/opt/oracle",
        command => "/usr/bin/systemctl enable redis-sentinel.service"
    }
		exec { "redis-start" :
		user   => root,
        group   => root,
        cwd     => "/opt/oracle",
        command => "/usr/bin/systemctl start redis.service"
    }
	
	exec { "redis-reload" :
		user   => root,
        group   => root,
        cwd     => "/opt/oracle",
        command => "/usr/bin/systemctl restart redis.service"
    }

}

