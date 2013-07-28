package Mentodo::Model::Entry;
use strict;
use warnings;
use utf8;

sub add {
    my $class = shift;
    my $db = shift;
    my $data = shift;

    return if !$data->{body} || !$data->{deadline};

    $db->insert(
        entries => {
            body => $data->{body},
            deadline => $data->{deadline},
        },
    );
}

sub del {
    my $class = shift;
    my $db = shift;
    my $data = shift;

    $db->delete(
        entries => {
            id => $data->{id},
        },
    );
}

sub list {
    my $class = shift;
    my $db = shift;

    $db->search('entries');
}

1;
