# == Class jmxtrans
# Installs a jmxtrans package and ensures that the jmxtrans service is running.
# The jmxtrans::metrics define includes this class, so you probably don't
# need to use it directly.
#
# == Parameters
class jmxtrans {
    package { 'jmxtrans':
        ensure  => 'installed',
    }
    service { 'jmxtrans':
        ensure  => 'running',
        enable  => true,
        require => Package['jmxtrans'],
    }
}
