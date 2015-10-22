# == Define jmxtrans::metrics::jvm
#
# Sets up this JVM to be monitored by a jmxtrans node.
# Note that at present this only really does the right thing with CMS and
# Parallel GC.
#
# == Parameters
# $jmx            - host:port of JMX to query.  Default: $title
# $ganglia        - $ganglia parameter to pass to jmxtrans::metrics
# $graphite       - $graphite parameter to pass to jmxtrans::metrics
# $outfile        - $outfile parameter to pass to jmxtrans::metrics
# $group_prefix   - Prefix string to prepend to ganglia_group_name and graphite_root_prefix.  Default: ''
#
define jmxtrans::metrics::jvm(
    $jmx          = $title,
    $ganglia      = undef,
    $graphite     = undef,
    $outfile      = undef,
    $group_prefix = '',
    $ensure       = 'file',
)
{
    jmxtrans::metrics { "${title}-jvm-metrics":
        ensure               => $ensure,
        jmx                  => $jmx,
        outfile              => $outfile,
        ganglia              => $ganglia,
        ganglia_group_name   => "${group_prefix}jvm_memory",
        graphite             => $graphite,
        graphite_root_prefix => "${group_prefix}jvm_memory",
        objects              => [
            {
                'name'        => 'java.lang:type=Memory',
                'resultAlias' => 'memory',
                'attrs'       => {
                    'HeapMemoryUsage'    => {'units' => 'bytes', 'slope' => 'both'},
                    'NonHeapMemoryUsage' => {'units' => 'bytes', 'slope' => 'both'},
                }
            },
            # Parallel GC
            {
                'name'        => 'java.lang:name=PS Scavenge,type=GarbageCollector',
                'resultAlias' => 'garbage_collector_incremental',
                'attrs'       => {
                    'CollectionCount' => {'units' => 'GCs', 'slope' => 'both'},
                    'CollectionTime'  => {'units' => 'milliseconds', 'slope' => 'positive'},
                }
            },
            {
                'name'        => 'java.lang:name=PS MarkSweep,type=GarbageCollector',
                'resultAlias' => 'garbage_collector_full',
                'attrs'       => {
                    'CollectionCount' => {'units' => 'GCs', 'slope' => 'both'},
                    'CollectionTime'  => {'units' => 'milliseconds', 'slope' => 'positive'},
                }
            },
            # CMS GC
            {
                'name'        => 'java.lang:name=ParNew,type=GarbageCollector',
                'resultAlias' => 'garbage_collector_incremental',
                'attrs'       => {
                    'CollectionCount' => {'units' => 'GCs', 'slope' => 'both'},
                    'CollectionTime'  => {'units' => 'milliseconds', 'slope' => 'positive'},
                }
            },
            {
                'name'        => 'java.lang:name=ConcurrentMarkSweep,type=GarbageCollector',
                'resultAlias' => 'garbage_collector_full',
                'attrs'       => {
                    'CollectionCount' => {'units' => 'GCs', 'slope' => 'both'},
                    'CollectionTime'  => {'units' => 'milliseconds', 'slope' => 'positive'},
                }
            },
            # These only show up for Java 7
            {
                'name'        => 'java.nio:name=mapped,type=BufferPool',
                'resultAlias' => 'buffer_pool_mapped',
                'attrs'       => {
                    'MemoryUsed' => {'units' => 'bytes', 'slope' => 'both'},
                    'Count'      => {'units' => 'buffers', 'slope' => 'both'},
                }
            },
            {
                'name'        => 'java.nio:name=direct,type=BufferPool',
                'resultAlias' => 'buffer_pool_direct',
                'attrs'       => {
                    'MemoryUsed' => {'units' => 'bytes', 'slope' => 'both'},
                    'Count'      => {'units' => 'buffers', 'slope' => 'both'},
                }
            }
        ]
    }
}
