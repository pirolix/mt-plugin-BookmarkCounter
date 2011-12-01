package MT::Plugin::OMV::HatenaBookmarkCounter;
# @see http://www.magicvox.net/archive/2010/01262245/

use strict;
use MT 4;
use base qw( MT::Plugin );
my $plugin = __PACKAGE__->new({
    id => __PACKAGE__,
    key => __PACKAGE__,
    name => __PACKAGE__,
});

### for MT4/MT5
MT->add_callback ('MT::App::CMS::template_source.entry_table', 5, $plugin, sub {
    my ($eh, $app, $tmpl) = @_;

    my $old = quotemeta (<<'HTMLHEREDOC');
<a href="<$mt:var name="entry_permalink"$>" target="<__trans phrase="_external_link_target">" title="<mt:if name="object_type" eq="entry"><__trans phrase="View entry"><mt:else><__trans phrase="View page"></mt:if>"><img src="<$mt:var name="static_uri"$>images/spacer.gif" alt="<mt:if name="object_type" eq="entry"><__trans phrase="View entry"><mt:else><__trans phrase="View page"></mt:if>" width="13" height="9" /></a>
HTMLHEREDOC
    my $new = <<'HTMLHEREDOC';
<br /><a href="http://b.hatena.ne.jp/entry/<$mt:var name="entry_permalink"$>"><img src="http://b.hatena.ne.jp/entry/image/<$mt:var name="entry_permalink"$>" /></a>
HTMLHEREDOC
    $$tmpl =~ s!($old)!$1$new!;
});

### for MT4/MT5
MT->add_callback ('MT::App::CMS::template_source.blog_stats_entry', 5, $plugin, sub {
    my ($eh, $app, $tmpl) = @_;

    my $old = <<'HTMLHEREDOC';
<h4><MTIf name="editable"><a href="<$mt:var name="script_url"$>?__mode=view&amp;_type=entry&amp;id=<$MTEntryID$>&amp;blog_id=<$MTBlogID$>"><MTGetVar name="entry_title"></a><MTElse name="author_id" eq="$entry_author_id"><a href="<$mt:var name="script_url"$>?__mode=view&amp;_type=entry&amp;id=<$MTEntryID$>&amp;blog_id=<$MTBlogID$>"><MTGetVar name="entry_title"></a><MTElse><MTGetVar name="entry_title"></MTIf>
HTMLHEREDOC
    chomp $old;
    $old = quotemeta ($old);
    my $new = <<'HTMLHEREDOC';
&nbsp;<a href="http://b.hatena.ne.jp/entry/<$MTEntryPermalink$>"><img src="http://b.hatena.ne.jp/entry/image/<$MTEntryPermalink$>" /></a>
HTMLHEREDOC
    $$tmpl =~ s!($old)!$1$new!;
});

### for MT4
MT->add_callback ('MT::App::CMS::template_source.edit_entry', 5, $plugin, sub {
    my ($eh, $app, $tmpl) = @_;

    my $target = qq!<ul id="bookmarks-list">!;

    $$tmpl =~ /\Q$target\E/
        or return; # do nothing

    my $new = << 'HTMLHEREDOC';
<li>Hatena Bookmark - <a href="http://b.hatena.ne.jp/entry/<$mt:var name="entry_permalink"$>"><img src="http://b.hatena.ne.jp/entry/image/<$mt:var name="entry_permalink"$>" /></a></li>
HTMLHEREDOC
    $$tmpl =~ s/(\Q$target\E)/$1$new/;
});

1;