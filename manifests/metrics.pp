# == Define jmxtrans::metrics
#
# Writes the config file causing this machine to monitor a set of metrics on a
# host.  That file is named /etc/jmxtrans/$title.json.
#
# Suggestion: use these as external resources to force one or more jmxtrans
# installs to monitor this machine.  See jmxtrans::metrics::jvm for an exmple.
#
# == Parameters
# $jmx                  - host:port of JMX to query (required)
# $objects              - array of hashes of the form:
#   [
#       {
#           "name"        => "JMX object name",
#           "resultAlias" => "pretty alias for JMX name",
#           "attrs"       => {
#               "attribute name" => {
#                   "units" => "unit name",
#                   "slope" => "slope type"
#               }
#           }
#       }
#   ]
# --resultAlias is optional
# --units is only required for ganglia
# ---Displayed with the graph to give context.  Nothing is worse than looking at
# ---a graph and not knowing if something is in seconds, milliseconds, or
# ---microseconds.
# --slope is only required for ganglia and is 'both', 'positive', or 'negative'
# ---See http://codeblog.majakorpi.net/post/16281432462/ganglia-xml-slope-attribute
# ---for more information including the rrd-beginners link if the concept sitll
# ---isn't clear.
# --Yes, the hash after attribute name could be empty.
# --No, we don't support replacing it with an array of names.
# $jmx_alias            - Server alias name.  Optional.
# $jmx_username         - JMX username (if there is one)  Optional.
# $jmx_password         - JMX password (if there is one)  Optional.
# $ganglia              - host:port of Ganglia gmond.  Optional.
# $ganglia_group_name   - Ganglia metrics group.  Optional.
# $graphite             - host:port of Graphite server  Optional.
# $graphite_root_prefix - rootPrefix for Graphite.  Optional.
# $outfile              - local file path in which to save metric query results.
#                           Optional.
#
define jmxtrans::metrics(
    $jmx,
    $objects,
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

    file { "/etc/jmxtrans/${title}.json":
        content => template('jmxtrans/jmxtrans.json.erb'),
        notify  => Service['jmxtrans'],
        require => Package['jmxtrans'],
    }
}
