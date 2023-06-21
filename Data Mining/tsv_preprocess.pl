#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

# Create a directory to store the processed files
my $dir = "files_processed";
mkdir $dir unless -d $dir;

# Get all the TSV files in the current directory
my @files = glob "*.tsv";

foreach my $file (@files) {
    # Open the input file for reading
    open(my $in, '<', $file) or die "Can't open $file: $!";

    # Create a new output file with ".processed.tsv" extension
    my $out_file = "$dir/" . basename($file);
    open(my $out, '>', $out_file) or die "Can't open $out_file: $!";

    print $out "gene_id\tgene_name\tgene_type\tfpkm_unstranded\n";

    # Read the input file line by line
    while (my $line = <$in>) {
        chomp $line;

        # Skip the first, third, fourth, fifth, and sixth rows
        next if ($. == 1 || $. == 3 || $. == 4 || $. == 5 || $. == 6);

        if ($. == 1) {
            print $out "$line\n";
            next;
        }

        # Split the line into an array using tab as the delimiter
        my @cols = split "\t", $line;

        # Skip the row if the gene_type is not "protein_coding"
        next if ($cols[2] ne "protein_coding");

        # Remove the unneeded columns
        splice @cols, 3, 5;

        # Print the modified row to the output file
        print $out join("\t", @cols) . "\n";
    }

    # Close the input and output files
    close $in;
    close $out;
}
