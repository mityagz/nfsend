package SYS_Packet;
require Exporter;
no integer;

@ISA = qw(Exporter);
@EXPORT = qw(get_sys_packet);



sub get_sys_packet {
$pixlog = shift;	

$acct_packet =0;
%PACKET_H = %{(shift)};
%PACKET = %{(shift)};

open(IFINDEX, "</usr/local/nfsend/ifindex.conf");
        while($index_str = <IFINDEX>){
                ($name, $index) = (split(/\=/, $index_str));
                chomp($index);
                $ifindex{$name} = $index;
        }
close(IFINDEX);

##open(FLOG,">> /home/mitya/pixlog.log");
##print FLOG $pixlog;
#print FLOG $1.' '.$2.' '.$3."srcport: ".$13."dstport: ".$16."PIXLOG\n";
##close(FLOG);


	if($pixlog =~ /bytes/){
		$acct_packet = 1;
		$pixlog =~ /(\w{3})\s+(\d+) (\d\d\:\d\d\:\d\d) (\d+\.\d+\.\d+\.\d+) (\w{3}) (\d\d \d\d\d\d) (\d\d\:\d\d\:\d\d)\: \%PIX\-6\-(\d+)\: Teardown (\w+) connection (\d+) for (\w+)\:(\d+\.\d+\.\d+\.\d+)\/(\d+) to (\w+)\:(\d+\.\d+\.\d+\.\d+)\/(\d+) duration (\d{1,2}\:\d\d\:\d\d) bytes (\d+).*/;


$PACKET_H{'version'} = $version = 5;
$PACKET_H{'count'} = $count = 1;
$PACKET_H{'sysuptime'} = $sysuptime = 00;
$PACKET_H{'unix_secs'}=$unix_secs = 00;
$PACKET_H{'unix_nsecs'}=$unix_secs = 00;
$PACKET_H{'flow_sequence'} = $main::flow_sequence += 1;
$PACKET_H{'engine_type'} = $engine_type = 00;
$PACKET_H{'engine_id'} = $engine_id = 00;
$PACKET_H{'sampling_interval'} = $sampling_interval = 00;

#$PACKET{'srcaddr'} = $srcaddr = pack('C4', $12);
#$PACKET{'dstaddr'} = $dstaddr = pack('C4', $15);
$PACKET{'srcaddr'} = $srcaddr = $12;
$PACKET{'dstaddr'} = $dstaddr = $15;
$PACKET{'nexthop'} = $nexthop = '0.0.0.0';
$PACKET{'input'} = $input = $ifindex{$11};
$PACKET{'output'} = $output = $ifindex{$14};
$PACKET{'dpkts'} = $dpkts = 1;
$PACKET{'doctets'} = $doctets = $18;
$PACKET{'first'} = $first = 0;
$PACKET{'last'} = $last = 0;
$PACKET{'srcport'} = $srcport = $13;
$PACKET{'dstport'} = $dstport = $16;
$PACKET{'pad1'} = $pad1 = 0;
$PACKET{'tcp_flags'} = $tcp_flags = 0;
$PACKET{'prot'} = $prot = 0;
$PACKET{'tos'} = $tos = 0;
$PACKET{'src_as'} = $src_as = 0;
$PACKET{'dst_as'} = $dst_as	= 0;
$PACKET{'src_mask'} = $src_mask = 32;
$PACKET{'dst_mask'} = $dst_mask = 32;
$PACKET{'pad2'} = $pad2 = 0;

	}
return (\%PACKET_H, \%PACKET, $acct_packet);
}

return 1;
