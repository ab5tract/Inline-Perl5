use v6;
use Test;
BEGIN {
    plan 2;
    if (try require File::Temp) === Nil {
        skip('File::Temp required for file handle tests', 2);
        exit;
    }
}
use Inline::Perl5;
use File::Temp;

my $p5 = Inline::Perl5.new;

$p5.run(q/
    use 5.14.0;
    sub foo {
        my ($handle) = @_;
        print { *$handle } "test!\n";
    }
/);

my ($filename, $filehandle) = tempfile;
$p5.call("foo", $filehandle);
ok 1, 'survived printing on a P6 file handle from P5';
$filehandle.close;

# re-open for reading, see RT #124056
$filehandle = $filename.IO.open(:r);

$p5.run(q/
    sub bar {
        my ($handle) = @_;
        return <$handle>;
    }
/);

is $p5.call('bar', $filehandle), 'test!';

# vim: ft=raku
