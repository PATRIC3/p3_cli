=head1 List Genome Groups

    p3-list-genome-groups [options]

    List genome groups in your workspace

=cut

use strict;
use Getopt::Long::Descriptive;
use P3WorkspaceClient;
use Data::Dumper;

my($opt, $usage) = describe_options("%c %o",
                                    ["help|h" => "Show this help message."]);
print($usage->text), exit 0 if $opt->help;
die($usage->text) if @ARGV != 0;

my $ws = P3WorkspaceClientExt->new();

my $home = $ws->home_workspace;
my $group_path = "$home/Genome Groups";

my $raw_groups = $ws->ls({paths => [$group_path]});
my @groups = sort { $a cmp $b } map { $_->[0] } grep { $_->[1] eq 'genome_group' } @{$raw_groups->{$group_path}};
print "$_\n" foreach @groups;
