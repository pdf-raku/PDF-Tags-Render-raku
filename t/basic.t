use Test;
use PDF::Tags::Render;
use PDF::API6;

plan 1;

my %role-map = U => :Span[:TextDecorationType("Underline")];
my Pair:D $doc-ast =
    :Document[
             :Lang<en>,
             :H1["A basic Test Document"],
             :P["This text is ", :U["underlined"], "."],
             :P["This text is of ", :Em["major significance"], "."],
             :P["This text is of ", :Strong["fundamental significance"], "."],
             :P["This text is verbatim C<with> B<disarmed> Z<formatting>."],
             :P["This text contains a link to ", :Link[:href("http://www.google.com/"), "http://www.google.com/"], "."],
             :P["This text contains a link with label to ", :Link[:href("http://www.google.com/"), "google"], "."],

             "#comment" => " a real-world sample, taken from Supply.pod6 ",
             :P["A tap on an ", :Code[:Span[ :role<Index>, "on demand"]]," supply will initiate the production of values,",
                "and tapping the supply again may result in a new set of values. For example, ", :Code[:Span[ :role<Index>,
                "Supply.interval"]], " produces a fresh timer with the appropriate interval each time it is tapped. If the ",
                "tap is closed, the timer simply stops emitting values to that tap."],
         ];

my PDF::API6 $pdf = PDF::Tags::Render.render($doc-ast, :%role-map);
$pdf.id = $*PROGRAM.basename.fmt('%-16.16s');
lives-ok { $pdf.save-as: "t/basic.pdf", :!info };

