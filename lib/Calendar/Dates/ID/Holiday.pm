package Calendar::Dates::ID::Holiday;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Calendar::Indonesia::Holiday;
use Role::Tiny::With;

with 'Calendar::DatesRoles::FromData';

our @ENTRIES;
my $res = Calendar::Indonesia::Holiday::list_id_holidays(detail=>1);
die "Cannot get list of holidays from Calendar::Indonesia::Holiday: $res->[0] - $res->[1]"
    unless $res->[0] == 200;
for my $e (@{ $res->[2] }) {
    $e->{summary} = delete $e->{eng_name};
    $e->{"summary.alt.lang.id"} = delete $e->{ind_name};
    if ($e->{eng_aliases} && @{ $e->{eng_aliases} }) {
        $e->{description} = "Also known as ".
            join(", ", @{ delete $e->{eng_aliases} });
    }
    if ($e->{ind_aliases} && @{ $e->{ind_aliases} }) {
        $e->{"description.alt.lang.id"} = "Juga dikenal dengan ".
            join(", ", @{ delete $e->{ind_aliases} });
    }
    push @ENTRIES, $e;
}

1;
# ABSTRACT: Indonesian holiday calendar

=head1 DESCRIPTION

This module provides Indonesian holiday calendar using the L<Calendar::Dates>
interface.
