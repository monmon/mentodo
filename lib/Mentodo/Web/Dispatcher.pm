package Mentodo::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::Lite;

any '/' => sub {
    my ($c) = @_;

    my @entries = Mentodo::Model::Entry->list($c->db);
    return $c->render(
        'index.tt' => {
            entries => \@entries,
        },
    );
};

post '/post' => sub {
    my($c) = @_;

    if (my($body, $deadline) = ($c->req->param('body'), $c->req->param('deadline'))) {
        Mentodo::Model::Entry->add($c->db, {
            body => $body,
            deadline => $deadline,
        });
    }

    $c->redirect('/');
};

post '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    return $c->redirect('/');
};

1;
