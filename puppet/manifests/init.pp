#class { 'core::preinstall' : }

class { 'core::install' : }

class { 'core::config' : }


if ( "${grunt_enabled}" == "true" ) {
	class { 'compilers::grunt' : }
}

if ( "${composer_enabled}" == "true" ) {
	class { 'compilers::composer' : }
}

if ( "${sass_enabled}" == "true" ) {
	class { 'compilers::sass' : }
}

class { 'core::restart' : }
