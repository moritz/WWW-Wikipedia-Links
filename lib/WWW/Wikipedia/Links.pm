package WWW::Wikipedia::Links;

use 5.008002;
use strict;
use warnings;
use Mojo::UserAgent;

=head1 NAME

WWW::Wikipedia::Links - The great new WWW::Wikipedia::Links!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use WWW::Wikipedia::Links qw/wiki_links/;
    my $links = wiki_links 'http://de.wikipedia.org/wiki/Ralf_Isau';
    if ($links) {
        for (@{ $links->{translations} }) {
            print $_->{lang}, ' ', $_->{url}, "\n";
        }
    }

=head1 EXPORT

Function C<wiki_links> is be exported if requested.

=head1 SUBROUTINES

=head2 wiki_links

=cut

sub wiki_links {
    _extract_from_dom(Mojo::UserAgent->new->get(shift)->res->dom);
}

sub _extract_from_dom {
    my $dom = shift;

    my %res;

    # languages
    {
        my $langs = $dom->at('#p-lang');
        $langs->find('li')->each( sub {
            my $lang  = (split '-', $_->attrs->{class})[1];
            my $url   =  $_->at('a')->attrs->{href};
            my $title =  $_->at('a')->attrs->{title};
            my %r;
            $r{lang}   = $lang  if defined $lang;
            $r{url}    = $url   if defined $url;
            $r{title}  = $title if defined $title;
            push @{ $res{translations} }, \%r if %r;
        } );
    }

    return \%res;

}
=head1 AUTHOR

Moritz Lenz, C<< <moritz at faui2k3.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-wikipedia-links at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Wikipedia-Links>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Wikipedia::Links


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Wikipedia-Links>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Wikipedia-Links>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Wikipedia-Links>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Wikipedia-Links/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Moritz Lenz.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of WWW::Wikipedia::Links
