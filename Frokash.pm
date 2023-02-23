#!/usr/bin/perl -w
use strict;
use Term::ANSIColor;
use Digest::MD5 qw(md5_hex);
my $datetime = localtime;
if ($^O =~ /MSWin32/) {system("cls"); }else { system("clear"); }
print color('bold green');
print q(
      ⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣠⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣄⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⡿⠋⢹⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⠟⣿⣿⣿⣿⣿⣿⣿⠟⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⠻⣿⣦⠀⠀⠀
⠀⢠⣾⡿⠋⣼⣿⣿⣿⣿⣿⣿⡏⠀⠀⠘⠻⠿⢿⣿⣿⣿⣿⣿⣧⠙⢿⣷⡄⠀
⢰⣿⡟⠀⠀⣿⣿⣧⡈⠉⠛⠿⠁⢠⣶⣶⡀⠀⠀⠈⠻⢿⣿⣿⣿⠀⠀⢻⣿⡆
⠈⢿⣿⣄⠀⣿⣿⣿⣿⣦⣄⡀⠀⠈⠛⠛⠀⢸⣷⣶⣤⣈⣿⣿⣿⠀⣠⣿⡿⠁
⠀⠀⠻⣿⣧⡸⣿⣿⣿⣿⣿⣿⣿⣷⡆⠀⢀⣿⣿⣿⣿⣿⣿⣿⢇⣴⣿⠟⠀⠀
⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀
⠀⠀⠀⠀⠀⠈⠙⠿⣿⣿⣿⣿⣿⣧⣶⣿⣿⣿⣿⣿⣿⣿⠿⠛⠁⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠛⠿⠿⠿⠿⠿⠿⠟⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
);

print color('reset');
print "                       ";
print colored ("[ R Raku v2.1 ]",'white on_red');
print colored ("[ Coded By Raku 8200 ]\n",'white on_red');
print "                           ";
print colored ("[ Start At $datetime ]",'white on_red'),"\n\n";use Net::FTP;

my $target_hash = shift;

my @charset =  ('a'..'z', 'A'..'Z', '0'..'9', qw(! @ # $ % ^ & * ( ) _ + - = { } [ ] \ | : ; " ' < > , . ? /));


my $password_length = 8;

my $num_passwords = 100000;


my @passwords;
for(my $i = 0; $i < $num_passwords; $i++) {
  my $password = '';
  for(my $j = 0; $j < $password_length; $j++) {
    $password .= $charset[int(rand(@charset))];
  }
  push(@passwords, $password);
}


sub check_password {
  my $password = shift;

  
  my $hashed_password = md5_hex($password);

  
  if($hashed_password eq $target_hash) {
    print "Password found: $password\n";
    exit;
  }
}


for(my $i = 0; $i < $num_passwords; $i++) {
  my $pid = fork();
  die "Could not fork: $!" unless defined($pid);
  if($pid == 0) {
    check_password($passwords[$i]);
    exit;
  }
}


for(my $i = 0; $i < $num_passwords; $i++) {
  wait();
}


print "Password not found.\n";
