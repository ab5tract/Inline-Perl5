use lib 't/lib';
use lib:from<Perl5> 't/lib';

use Test;
use Precomp;

ok Precomp::test-dumper;
ok Precomp::test-class;

ok Precomp::test-class.Reset.Reset.Reset;

done-testing;
