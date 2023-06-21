#!/usr/bin/perl

use strict;
use warnings;
use File::Basename;

# Create a directory to store the processed files
my $dir = "processed_files";
mkdir $dir unless -d $dir;

# Get all the input files in the current directory
my @files = glob "*.tsv";

foreach my $file (@files) {
    # Open the input file for reading
    open(my $in, '<', $file) or die "Can't open $file: $!";

    # Create a new output file in the video_files directory with the same name as the input file
    my $out_file = "$dir/" . basename($file);
    open(my $out, '>', $out_file) or die "Can't open $out_file: $!";

    # Read the input file line by line
    while (my $line = <$in>) {
        chomp $line;

        # If it's the first line, skip it
        if ($. == 1) {
            next;
        }

        # Split the line into an array using tab as the delimiter
        my @cols = split "\t", $line;

        # Print the modified row to the output file
        print $out "$cols[0]\t$cols[3]\n";
    }

    # Close the input and output files
    close $in;
    close $out;
}

