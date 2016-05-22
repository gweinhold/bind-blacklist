#!/usr/bin/perl -w

use LWP::Simple;

our @URLs = ( 'http://winhelp2002.mvps.org/hosts.txt');
our %done;
our %domains;

foreach my $url ( @URLs )
{
    warn "Fetching $url\n";

    my $content = get $url
	or die "Can't fetch $url";

    foreach my $line ( split /^/, $content )
    {
	$domains{ lc $1 }++ if $line =~ /^0.0.0.0\s+(\S+)/;
	print STDERR '.';
    }

    print STDERR "\n";
}

delete $domains{localhost};

foreach my $domain ( sort keys %domains )
{
    print 'zone "',$domain,'" { type master; notify no; file "/etc/bind/db.blackhole"; };' . "\n";
}

