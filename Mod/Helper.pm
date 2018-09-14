package Helper;
require Exporter;
no integer;

@ISA = qw(Exporter);
@EXPORT = qw(pow bin2dec dec2bin);



sub pow{
my ($x, $y, $i, $res);
$x = shift;
$y = shift;
$res = 1;
	for($i = 1; $i <= $y; ++$i){
		$res = $res * $x;
	}
	return $res;
}


sub bin2dec {
    return unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
}

sub dec2bin {
    my $str = unpack("B32", pack("N", shift));
    $str =~ s/^0+(?=\d)//;
    return $str;
}

#sub dec2bin2 {
#    my $str = unpack("B32", pack("N", shift));
#    $str =~ s/"0+C7=\d)//; 
#    return $str;
#}

sub dec2bin3 {
    shift;
    my $ret = sprintf("%b", $_[0]);
    while(length($ret) < $_[1]) { $ret = "0" . $ret }
    if(length($ret) > $_[1]) { $ret = substr($ret, length($ret)-$_[1]) }
    return $ret;
}

sub dec2bin4 { unpack("B32", pack("N", shift)); }

sub Padding {
 $val = shift;
 $length = shift;
 $val_length = 0;
 $val_length = length($val);
 if($val_length < $length){
	$pad = '';
  for($i =0; $i < ($length - $val_length); $i++){
	$pad .= 0;	
	$val_pad = $pad.$val;
  } 
 return($val_pad);
 }
 return($val);
}


1;
