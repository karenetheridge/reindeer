package Reindeer::Role;

# ABSTRACT: Reindeer in role form

use strict;
use warnings;

use Reindeer::Util;
use Moose::Exporter;

my (undef, undef, $init_meta) = Moose::Exporter->build_import_methods(

    install => [ qw{ import unimport } ],

    also => [ 'Moose::Role', Reindeer::Util::also_list() ],

    role_metaroles => {
        role => [ qw{
            MooseX::MarkAsMethods::MetaRole::MethodMarker
        } ],
    },
);

sub init_meta {
    my ($class, %options) = @_;
    my $for_class = $options{for_class};

    ### $for_class
    Moose::Role->init_meta(for_class => $for_class);
    Reindeer::Util->import_type_libraries({ -into => $for_class });
    Try::Tiny->export_to_level(1);

    # erm...  wtf?
    goto $init_meta if defined $init_meta;
}

!!42;

__END__

=head1 SYNOPSIS

    # ta-da!
    use Reindeer::Role;

=head1 DESCRIPTION

For now, see the L<Reindeer> docs for information about what meta extensions
are automatically applied.

=head1 SEE ALSO

L<Reindeer>, L<Moose::Role>

=cut