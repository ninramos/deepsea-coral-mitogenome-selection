#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

MAIN: {
    my $t_file = $ARGV[0] or die "usage: $0 TREE_FILE ALN_FILE\n";
    my $a_file = $ARGV[1] or die "usage: $0 TREE_FILE ALN_FILE\n";

    my @t_files = ();
    open IN, $t_file or die "cannot open $t_file:$!";
    while (my $line = <IN>) {
        chomp $line;
        next if ($line =~ m/^\s*$/);
        $line =~ s/\s+$//;
        push @t_files, $line;
    }

    my @a_files = ();
    open IN, $a_file or die "cannot open $a_file:$!";
    while (my $line = <IN>) {
        chomp $line;
        next if ($line =~ m/^\s*$/);
        $line =~ s/\s+$//;
        push @a_files, $line;
    }

#    my %data = ();
    for (my $i = 0; $i < @t_files; $i++) { 
        system("echo seqfile = /bwdata2/2019workshop/d.deleo/PAML_Hyphy/$a_files[$i] >> $a_files[$i].ctl");
        system("echo treefile = /bwdata2/2019workshop/d.deleo/PAML_Hyphy/$t_files[$i] >> $a_files[$i].ctl");
        system("echo outfile = /bwdata2/2019workshop/d.deleo/PAML_Hyphy/mlcnull_$a_files[$i] >> $a_files[$i].ctl");
        system("echo noisy = 4 >> $a_files[$i].ctl");
        system("echo verbose = 1 >> $a_files[$i].ctl");
        system("echo runmode = 0 >> $a_files[$i].ctl");
        system("echo seqtype = 1 >> $a_files[$i].ctl");
        system("echo CodonFreq = 2 >> $a_files[$i].ctl");
        system("echo estFreq = 0 >> $a_files[$i].ctl");
        system("echo ndata = 1 >> $a_files[$i].ctl");
        system("echo clock = 0 >> $a_files[$i].ctl");
        system("echo aaDist = 0 >> $a_files[$i].ctl");
        system("echo model = 2 >> $a_files[$i].ctl");
        system("echo NSsites = 2 >> $a_files[$i].ctl");
        system("echo icode = 4 >> $a_files[$i].ctl");
        system("echo Mgene = 0 >> $a_files[$i].ctl");
        system("echo fix_kappa = 0 >> $a_files[$i].ctl");
        system("echo kappa = 2 >> $a_files[$i].ctl");
        system("echo fix_omega = 1 >> $a_files[$i].ctl");
        system("echo omega = 1 >> $a_files[$i].ctl");
        system("echo fix_alpha = 1 >> $a_files[$i].ctl");
        system("echo alpha = 0 >> $a_files[$i].ctl");
        system("echo Malpha = 0 >> $a_files[$i].ctl");
        system("echo ncatG = 5 >> $a_files[$i].ctl");
        system("echo getSE = 0 >> $a_files[$i].ctl");
        system("echo RateAncestor = 0 >> $a_files[$i].ctl");
        system("echo Small_Diff = 5e-7 >> $a_files[$i].ctl");
        system("echo cleandata = 0 >> $a_files[$i].ctl");
        system("echo fix_blength = 1 >> $a_files[$i].ctl");
        system("echo method = 0 >> $a_files[$i].ctl");

#        $data{$a_files[$i]} = $t_files[$i];
    }
#    system Dumper \%data;
}

