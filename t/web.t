use strict;
use warnings;
use utf8;
use t::Util;
use Test::More;
use Test::Pretty;
use Test::WWW::Mechanize::PSGI;
use Mentodo::Web;

my $app = Plack::Util::load_psgi 'app.psgi';

subtest 'TODOが追加でき、表示される' => sub {
    my $mech = Test::WWW::Mechanize::PSGI->new(app => $app);

    subtest '/にアクセスするとbodyとdeadlineのinputがある' => sub {
        $mech->get_ok('http://localhost:5000/', '/にアクセスできるか');
        $mech->content_like(qr/input.+type="text".+name="body"/, 'bodyがあるか');
        $mech->content_like(qr/input.+type="text".+name="deadline"/, 'deadlineがあるか');
    };

    subtest '正しいpostをすると追加されたものが表示される' => sub {
        my($body, $deadline) = ('test', '2013-07-21');

        $mech->submit_form_ok(+{
            fields => +{
                body => $body,
                deadline => $deadline,
            }
        }, 'submitできたか');

        $mech->content_like(qr/$deadline.+$body/, '追加したものが表示されているか');
    };
};

done_testing;
