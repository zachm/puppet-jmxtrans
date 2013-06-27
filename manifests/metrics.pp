# == Define jmxtrans::metrics
#
# Writes a jmxtrans JSON file in
# /var/lib/jmxtrans/$title.json.
# Each file in this directory should correspond to a single
# JMX instance and specify the object and metric names to query
# the JMX instance for.
#
# == Parameters
# $jmx                  - host:port of JMX to query (required)
# $queries              - array of hashes of the form [ { "obj" => "JMX object name", "attr" => [ "array", "of", "JMX", "metric", "names" ] }, ... ]
# $jmx_alias            - Server alias name.  Optional.
# $jmx_username         - JMX username (if there is one)  Optional.
# $jmx_password         - JMX password (if there is one)  Optional.
# $ganglia              - host:port of Ganglia gmond.  Optional.
# $ganglia_group_name   - Ganglia metrics group.  Optional.
# $graphite             - host:port of Graphite server  Optional.
# $graphite_root_prefix - rootPrefix for Graphite.  Optional.
# $outfile              - local file path in which to save metric query results.  Optional.
#
define jmxtrans::metrics(
    $jmx,
    $queries,
    $jmx_alias            = undef,
    $jmx_username         = undef,
    $jmx_password         = undef,
    $ganglia              = undef,
    $ganglia_group_name   = undef,
    $graphite             = undef,
    $graphite_root_prefix = undef,
    $outfile              = undef
)
{
    include jmxtrans

    file { "/var/lib/jmxtrans/${title}.json":
        content => template('jmxtrans/jmxtrans.json.erb'),
        notify  => Service['jmxtrans'],
        require => Package['jmxtrans'],
    }
}