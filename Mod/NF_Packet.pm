package NF_Packet;
require Exporter;
no integer;

@ISA = qw(Exporter);
@EXPORT = qw(make_nf_packet);



sub make_nf_packet {
%PACKET_H = %{(shift)};
%PACKET = %{(shift)};
my %ifindex;
my $nf_export = '';



#open(IFINDEX, "<ifindex.conf");
#	while($index_str = <IFINDEX>){
#		($name, $index) = (split(/\=/, $index_str));
#		chomp($index);
#		$ifindex{$name} = $index;
#	}
#close(IFINDEX);


#	foreach $pckt_h (keys %PACKET_H){
#		print "$pckt_h: ".$PACKET_H{$pckt_h}."\n";
#	}
#	print "------------------------------------\n";
#	foreach $pckt (keys %PACKET){
#		if(($pckt eq "input") or ($pckt eq "output")){
#		 print "$pckt: ".$ifindex{$PACKET{$pckt}}."\n";
#		}else{
#		 print "$pckt: ".$PACKET{$pckt}."\n";
#		}
#	}
#	print "------------------------------------\n";

#print Helper::dec2bin($PACKET_H{'version'})."\n";
#print Helper::Padding(Helper::dec2bin(130), 16)."\n";

$nf_export = pack("B16 B16 B32 B32 B32 B32 B8 B8 B16
		   C4 C4 C4 B16 B16 B32 B32 B32 B32 B16 B16 B8 B8 B8 B8 B16 B16 B8 B8 B16", 
						  Helper::Padding(Helper::dec2bin($PACKET_H{'version'}),16),
						  Helper::Padding(Helper::dec2bin($PACKET_H{'count'}),16),
						  Helper::Padding(Helper::dec2bin($PACKET_H{'sysuptime'}),32),
						  Helper::Padding(Helper::dec2bin($PACKET_H{'unix_secs'}),32),
						  Helper::Padding(Helper::dec2bin($PACKET_H{'unix_nsecs'}),32),
						  Helper::Padding(Helper::dec2bin($PACKET_H{'flow_sequence'}),32),
						  Helper::Padding(Helper::dec2bin($PACKET_H{'engine_type'}),8),
						  Helper::Padding(Helper::dec2bin($PACKET_H{'engine_id'}),8),
						  Helper::Padding(Helper::dec2bin($PACKET_H{'sampling_interval'}),16),

						  split(/\./, $PACKET{'srcaddr'}),
						  split(/\./, $PACKET{'dstaddr'}),
						  split(/\./, $PACKET{'nexthop'}),
						  Helper::Padding(Helper::dec2bin($PACKET{'input'}),16),
						  Helper::Padding(Helper::dec2bin($PACKET{'output'}),16),

						  Helper::Padding(Helper::dec2bin($PACKET{'dpkts'}),32),
						  Helper::Padding(Helper::dec2bin($PACKET{'doctets'}),32),
						  Helper::Padding(Helper::dec2bin($PACKET{'first'}),32),
						  Helper::Padding(Helper::dec2bin($PACKET{'last'}),32),

						  Helper::Padding(Helper::dec2bin($PACKET{'srcport'}),16),
						  Helper::Padding(Helper::dec2bin($PACKET{'dstport'}),16),

						  Helper::Padding(Helper::dec2bin($PACKET{'pad1'}),8),
						  Helper::Padding(Helper::dec2bin($PACKET{'tcp_flags'}),8),
						  Helper::Padding(Helper::dec2bin($PACKET{'prot'}),8),
						  Helper::Padding(Helper::dec2bin($PACKET{'tos'}),8),

						  Helper::Padding(Helper::dec2bin($PACKET{'src_as'}),16),
						  Helper::Padding(Helper::dec2bin($PACKET{'dst_as'}),16),

						  Helper::Padding(Helper::dec2bin($PACKET{'src_mask'}),8),
						  Helper::Padding(Helper::dec2bin($PACKET{'dst_mask'}),8),
						  Helper::Padding(Helper::dec2bin($PACKET{'pad2'}),16)

						  );



return $nf_export;

}


return 1;
