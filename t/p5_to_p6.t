#!/usr/bin/env perl6

use v6;
use Test;
use Inline::Perl5;

my $p5 = Inline::Perl5.new();

is $p5.run('5'), 5;
is $p5.run('5.5'), 5.5;
is $p5.run('"Perl 5"'), 'Perl 5';
is-deeply $p5.run('\"foo"'), \('foo');
is $p5.run('[1, 2]'), [1, 2]; # Can't use is-deeply since we get a Perl5Array instead of Array
is $p5.run('[1, [2, 3]]'), [1, [2, 3]];
is $p5.run('{a => 1, b => 2}'), {a => 1, b => 2}; # Can't use is-deeply since we get a Perl5Hash
is $p5.run('{a => 1, b => {c => 3}}'), {a => 1, b => {c => 3}};
is $p5.run('[1, {b => {c => 3}}]'), [1, {b => {c => 3}}];
ok $p5.run('undef') === Any, 'p5 undef maps to p6 Any';

is $p5.run('
    use utf8;
    "Pörl 5"
'), 'Pörl 5';

is $p5.run('
    use utf8;
    use Encode;
    encode("latin-1", "Pörl 5");
').decode('latin-1'), 'Pörl 5';

$p5.DESTROY;

done-testing;

# vim: ft=raku
