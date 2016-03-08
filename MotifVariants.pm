
package MotifVariants;

# Links
# http://uswest.ensembl.org/info/docs/tools/vep/script/vep_plugins.html?redirect=no
# http://uswest.ensembl.org/info/docs/Doxygen/variation-api/index.html
# example: https://github.com/Ensembl/VEP_plugins/blob/master/MaxEntScan.pm

use strict;
use warnings;

use base qw(Bio::EnsEMBL::Variation::Utils::BaseVepPlugin);

sub run {
    my (
	$self,
	$transcript_variation_allele,
	) = @_;

    foreach variant_neighborhood
        find motif in reference neighborhood
	find motif in variant neighborhood
}

sub is_known_motif {
    my ($query) = @_;

}

sub get_header_info {
    return {
	
	;
}

sub feature_types {
    return [
	'Feature',
	'Intergenic',
	];
}
