#!/usr/bin/perl -w
use strict;
use warnings;

my $zmmailbox  = '/opt/zimbra/bin/zmmailbox -z -m';
my @email_id = '';

##Example: mcoa@example.com - DD/MM/YY - /Inbox
my ($account, $date, $folder) = @ARGV;
    open(FILE, ">/tmp/report_$account") or die "Cannot open file";
    @email_id = `$zmmailbox $account search -l 1000 "in:$folder (before:$date)" | grep conv | awk {'print \$2'} |sed s/\-//g`;
    for my $id (@email_id) {
        printf FILE "Delete email with ID: $id";
        system("$zmmailbox $account dm $id");
    }
close(FILE);
