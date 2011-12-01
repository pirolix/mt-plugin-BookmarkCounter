package MT::Plugin::OMV::BookmarkCounterCommon;

use strict;
use MT 4;
use base qw( MT::Plugin );
my $plugin = __PACKAGE__->new({
    id => __PACKAGE__,
    key => __PACKAGE__,
    name => __PACKAGE__,
});

### for MT4
MT->add_callback ('MT::App::CMS::template_source.edit_entry', 1, $plugin, sub {
    my ($eh, $app, $tmpl) = @_;

    my $old = quotemeta (<<'HTMLHEREDOC');
    </mtapp:widget>
    <mt:if name="agent_ie"><div>&nbsp;<!-- IE Duplicate Characters Bug -->&nbsp;</div></mt:if>
HTMLHEREDOC
    my $new = << 'HTMLHEREDOC';
<mtapp:widget
   id="entry-reactions"
   label="<__trans phrase="Reactions">">
        <mtapp:setting
            id="bookmarks"
            label="<__trans phrase="Bookmarks">">
<ul id="bookmarks-list">
</ul>
        </mtapp:setting>

</mtapp:widget>
HTMLHEREDOC
    $$tmpl =~ s/($old)/$1$new/;
});

1;