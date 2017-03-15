#class { 'core::preinstall' : }

class { 'core::install' : }

class { 'core::config' : }



	class { 'compilers::grunt' : }



	#class { 'compilers::composer' : }


	class { 'compilers::sass' : }


class { 'core::restart' : }
