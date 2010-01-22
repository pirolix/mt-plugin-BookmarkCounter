package MT::Plugin::SKR::YahooBookmarkCounter;
# @see 

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
<br /><a href="http://bookmarks.yahoo.co.jp/url?url=<$mt:var name="entry_permalink"$>"><img src="http://num.bookmarks.yahoo.co.jp/image/small/<$mt:var name="entry_permalink"$>" /></a>
HTMLHEREDOC
    $$tmpl =~ s!($old)!$1$new!;
});

1;