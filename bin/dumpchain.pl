#!/usr/bin/perl

# Script dumps the whole certificate chain for a server in purposes of OSCP
# stapling.
# ---
# This is a fork from https://gist.github.com/sanmai/98666f96294d05c64172
# Thank you, Sanmai!

use strict;
use warnings;
# install libio-socket-ssl-perl to get this
use IO::Socket::SSL;

my $hostname = shift or die "Usage: $0 www.example.com\n";

IO::Socket::SSL->new(
    PeerHost => "$hostname:443",
    SSL_verify_callback => sub {
        my $cert = $_[4];
        my $subject = Net::SSLeay::X509_NAME_oneline(Net::SSLeay::X509_get_subject_name($cert));
        print "# $subject\n";
        print Net::SSLeay::PEM_get_string_X509($cert),"\n";
        return 1;
    }
) or die $SSL_ERROR||$!;
