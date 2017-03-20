#class { 'core::preinstall' : }

class { 'core::install' : }

class { 'core::java'  :}

class { 'core::config' : }

class { 'compilers::grunt' : }

#class { 'compilers::composer' : }

class { 'compilers::sass' : }

class{ 'wls::java'	:}

class{ 'deploy::config'	:}

class{ 'deploy::dmz'	:}

class{ 'deploy::functional'	:}

class { 'core::restart' : }
