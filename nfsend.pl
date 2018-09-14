#!/usr/bin/perl -w

use POSIX;
use IO::Socket;
use IO::Socket::INET;
use IO::Select;
use Socket;
use Fcntl;
use Tie::RefHash;
use lib ("/usr/local/nfsend/Mod");
use Helper;
use NF_Packet;
use SYS_Packet;

$nf_host = "127.0.0.1";
#$nf_host = "10.2.1.152";
$nf_port = "9999";

$main::flow_sequence = 0;

$|=1;

# Client
$client = IO::Socket::INET->new(PeerAddr => $nf_host,
				PeerPort => $nf_port,
				Proto     => 'udp')
  or die "Can't make client socket: $_\n";

my %PACKET_H = ();
my %PACKET = ();
my $acct_packet;
my %NF_PACKET;






while($pixlog = <>){


$R_PACKET_H = \%PACKET_H;
$R_PACKET = \%PACKET;

($R_PACKET_H, $R_PACKET, $acct_packet) = SYS_Packet::get_sys_packet($pixlog, $R_PACKET_H, $R_PACKET);
	if($acct_packet == 1){
		$nf_export = NF_Packet::make_nf_packet($R_PACKET_H, $R_PACKET);
		$rv = $client->send($nf_export, 0);
	}
}






=item
Description netflow header v5 format
                                -1
------------------------------------
index   content         description
------------------------------------
1       version
2       count
3       SysUptime
4       unix_secs
5       unix_nsecs
6       flow_sequence
7       rezerved
8       rezerved
9       rezerved
10      rezerved
------------------------------------
=cut


=item
Description netflow v5 packet format
                                -1
------------------------------------
index   content         description
------------------------------------
1-4     srcaddr
5-8     dstaddr
9-12    nexthop
13      input
14      output
15      dPkts
16      dOctets
17      First
18      Last
19      srcport
20      dstport
21      pad1
22      tcp_flags
23      prot
24      tos
25      src_as
26      dst_as
27      src_mask
28      dst_mask
29      pad2
------------------------------------
=cut
