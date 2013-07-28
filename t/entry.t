use strict;
use warnings;
use utf8;
use Test::More;
use Test::Pretty;
use Test::MockObject;
use Mentodo::Model::Entry;

subtest 'bodyとdeadlineがあればTODOを追加できる' => sub {
    subtest 'bodyとdeadlineがあればOK' => sub {
        my $db = Test::MockObject->new->set_true('insert');

        my $is_added = Mentodo::Model::Entry->add($db, {
            body     => 'test',
            deadline => '2013-07-30',
        });

        ok $is_added, '追加されたか';
        ok $db->called('insert'), 'insertは呼ばれたか';
    };

    subtest 'deadlineがなければNG' => sub {
        my $db = Test::MockObject->new;

        my $is_added = Mentodo::Model::Entry->add($db, {
            body     => 'test',
        });

        ok !$is_added, '追加されなかったか';
        ok !$db->called('insert'), 'insertは呼ばれていないか';
    };
};

subtest 'idを指定した時にそのidがあれば削除できる' => sub {
    subtest 'idがあれば削除できる' => sub {
        my $db = Test::MockObject->new->set_true('delete');

        my $is_deled = Mentodo::Model::Entry->del($db, {
            id => 1,
        });

        ok $is_deled, '削除できたか';
        ok $db->called('delete'), 'deleteは呼ばれたか';
    };

    subtest 'idが存在しなければNG' => sub {
        my $db = Test::MockObject->new->set_false('delete');

        my $is_added = Mentodo::Model::Entry->del($db, {
            id => 1,
        });

        ok !$is_added, '追加されなかったか';
        ok $db->called('delete'), 'deleteは呼ばれたか';
    };
};

subtest '追加したTODOを全部呼び出せる' => sub {
    my $db = Test::MockObject->new->mock('search', sub {
        return [
            Test::MockObject->new
                ->mock('id', sub {1})
                ->mock('body', sub {'test'})
                ->mock('deadline', sub {'2013-07-14'})
        ];
    });

    my $entries_ref = Mentodo::Model::Entry->list($db);

    is $entries_ref->[0]->id, 1, 'idが1か';
    is $entries_ref->[0]->body, 'test', 'bodyがtestか';
    is $entries_ref->[0]->deadline, '2013-07-14', 'deadlineが2013-07-14か';
};

done_testing;
