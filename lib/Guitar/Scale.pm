package Guitar::Scale;

# Copyright (C) 2013 by Mitsuru Yasuda. All rights reserved.
# mail bugs, comments and feedback to dsyrtm@cpan.org

use strict;
use warnings;
our $VERSION = '0.01';

sub pv {
	#
	#
	# use Guitar::Scale;
	# print Guitar::Scale::pv('A', 'Blues');
	#
	#
	my ($_key, $_t, $mode)  = @_;
	           $_t ||= 'Minor';
	my %type = (
	  'Minor'           => '201101011010',
	  'HarmonicMinor'   => '201101011001',
	  'MelodicMinor'    => '201101010101',
	  'Pentatonic'      => '200101010010',
	  'Blues'           => '200101110010',
	  'Diminished'      => '201101101101',
	  'Dorian'          => '201101010110',
	  'Ionian'          => '201011010101',
	  'Phrygian'        => '210101011010',
	  'Lydian'          => '201010110101',
	  'Mixolydian'      => '201011010110',
	  'Aeolian'         => '201101011010',
	  'WholeTone'       => '201010101010',
	  'Major'           => '201011010101',
	  'Japanese'        => '210001100010',
	  'Sobaya'          => '210001011000',
	  'Spanish'         => '210011011010',
	  'Roumanian'       => '201100110110',
	  'Egyptian'        => '201001010010',
	  'Hawaiian'        => '201101010101',
	  'Hindu'           => '201011011010',
	  'Ryukyu'          => '200011010001',
	  'HeavyMetal'      => '201101110110',
	);
	my @key = (
	  'E','F','F#|Gb','G','G#|Ab','A','A#|Bb','B','C','C#|Db','D','D#|Eb'
	);

	#
	# your homemade @(^-^)@
	#
	if ($_t =~ /^2\d{11}$/) { $type{$_t} = $_t }

	# make scale
	my $st  = 0;
	for my $s ( 0 .. $#key ){
		if ($_key =~ /^$key[$s]$/i) { $st = $s; last }
	}
	my $col = substr(substr($type{$_t}, 12-$st, $st).$type{$_t} ,0 ,12) x 4;

	# print scale
	my 
	$str  = substr($col,  0, 25). "\n";
	$str .= substr($col,  7, 25). "\n";
	$str .= substr($col,  3, 25). "\n";
	$str .= substr($col, 10, 25). "\n";
	$str .= substr($col,  5, 25). "\n";
	$str .= substr($col,  0, 25). "\n";
	$mode || do {
	 $str =~ s/0/--+/g;
	  $str =~ s/1/<>+/g;
	   $str =~ s/2/[]+/g;# bass key
	    for my $i ( 0 .. 24 ){ $str .= sprintf("%02d ", $i) }
	};
	return $str;
}

__END__


=head1 NAME

Guitar::Scale.pm - confirm the guitar scale.


=head1 SYNOPSIS

	use Guitar::Scale;

	# .. preview scale
	Guitar::Scale::pv('C', 'Blues');

	# .. Other
	Guitar::Scale::pv('B', 'Spanish');

	# .. Other
	Guitar::Scale::pv('C#', 'HeavyMetal');

	# .. Your Handmade Scale
	Guitar::Scale::pv('F', '201000010000');


=head1 DESCRIPTION

I can view the guitar scale easily.
In addition, it is also possible to check by shifting the base sound.


=head1 OBJECT INTERFACE
 
These are the methods in C<use Guitar::Scale> object interface.

=head2 C<scale>

C<pv> can see the sound of all of the finger board.

	pv($key, $type, [mode]);

C<key>

	E F F# Gb G G# Ab A A# Bb B C C# Db D D# Eb

C<type>

	'HeavyMetal'
	'Minor'
	'HarmonicMinor'
	'MelodicMinor'
	'Pentatonic'
	'Blues'
	'Diminished'
	'Dorian'
	'Ionian'
	'Phrygian'
	'Lydian'
	'Mixolydian'
	'Aeolian'
	'WholeTone'
	'Major'
	'Japanese'
	'Sobaya'
	'Spanish'
	'Roumanian'
	'Egyptian'
	'Hawaiian'
	'Hindu'
	'Ryukyu'

C<mode> is optional; the default is '0'.

	0: normal preview -> <>+<>+--+<>+
	1: binary preview -> 201101010101


=head1 Handmade Scale

Guitar::Scale::pv('E', '201000010000');
Set the fingerboard the second argument.
Be a binary of 12 digits starting from C<2> Always.
Assume the E first because the bass sound.

	Example:
	[]+--+--+<>+--+<>+<>+<>+--+--+<>+--+ => '200101110010'


=head1 Example

	Guitar::Scale::pv('A', 'Blues');
	
	<>+--+--+<>+--+[]+--+--+<>+--+<>+<>+<>+--+--+<>+--+[]+--+--+<>+--+<>+<>+<>+
	--+<>+--+<>+<>+<>+--+--+<>+--+[]+--+--+<>+--+<>+<>+<>+--+--+<>+--+[]+--+--+
	<>+--+[]+--+--+<>+--+<>+<>+<>+--+--+<>+--+[]+--+--+<>+--+<>+<>+<>+--+--+<>+
	<>+<>+<>+--+--+<>+--+[]+--+--+<>+--+<>+<>+<>+--+--+<>+--+[]+--+--+<>+--+<>+
	[]+--+--+<>+--+<>+<>+<>+--+--+<>+--+[]+--+--+<>+--+<>+<>+<>+--+--+<>+--+[]+
	<>+--+--+<>+--+[]+--+--+<>+--+<>+<>+<>+--+--+<>+--+[]+--+--+<>+--+<>+<>+<>+
	00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 
	
	--: none.
	<>: active.
	[]: base.


=head1 Example

	Guitar::Scale::pv('A', 'Blues' ,1);
	
	1001020010111001020010111
	0101110010200101110010200
	1020010111001020010111001
	1110010200101110010200101
	2001011100102001011100102
	1001020010111001020010111
	
	0: none.
	1: active.
	2: base.


=head1 HeavyMetal

HeavyMetal scale is the original scale of Mitsuru Yasuda.


=head1 AUTHOR

Mitsuru Yasuda, dsyrtm@cpan.org

	http://simql.com/


=head1 COPYRIGHT & LICENSE

Copyright (C) 2013 by Mitsuru Yasuda &

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.


=cut

1;