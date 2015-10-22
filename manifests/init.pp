# == Class jmxtrans
# Installs a jmxtrans package and ensures that the jmxtrans service is running.
# The jmxtrans::metrics define includes this class, so you probably don't
# need to use it directly.
#
# == Parameters
# $installed    - set to false and everything is deleted. Default: true
# $run_interval - seconds between runs of jmx queries.  Default: 15
# $log_level    - level at which to log jmxtrans messages.  Default: 'info'
#
class jmxtrans(
    $installed    = true,
    $run_interval = 15,
    $log_level    = 'info',
    $json_dir     = '/etc/jmxtrans',
)
{
    validate_bool($installed)
    if $installed  == true {
        package { 'jmxtrans':
            ensure  => 'installed',
        }

        file { $json_dir:
            ensure  => 'directory',
            purge   => true,
            force   => true,
            recurse => true,
        }

        file { '/etc/default/jmxtrans':
            content => template('jmxtrans/jmxtrans.default.erb')
        }

        service { 'jmxtrans':
            ensure    => 'running',
            enable    => true,
            require   => Package['jmxtrans'],
            subscribe => File['/etc/default/jmxtrans', $json_dir],
        }
    } else {
        service { 'jmxtrans':
            enable => false,
            ensure => 'stopped'
        }
        package { 'jmxtrans':
            ensure => 'purged',
        }
        file { $json_dir:
            ensure  => 'absent',
            force   => true,
            recurse => true,
        }
        file { '/etc/default/jmxtrans':
            ensure => 'absent',
        }
    }
}
