# WEB

## standalone

    plackup app.psgi -R lib

# CLI

    perl -Ilib -MMentodo -e '$app = Mentodo->bootstrap; Mentodo::Model::Entry->add($app->context->db, { body => "test2", deadline => "1999-01-01" }); warn join "\n", map { $_->deadline . " : " . $_->body } Mentodo::Model::Entry->list($app->context->db)';
