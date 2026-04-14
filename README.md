PDF-Render
===========

Description
-----------

Simple rendering of tagged PDF trees.

Synopsis
--------

```raku
use PDF::Tags::Render;

my %role-map = (
    'U' => :Span[:TextDecorationType<Underline>],
    'X' => :Index[],
);

my Pair:D $pdf-ast =
    :Document[ :Lang<en>,
        :H1["A basic Test Document"],
        :P["This text is ", :Em["italic"], "."],
        :P["This text is ", :Strong["bold"], "."],
        :P["This text is ", :U["underlined"], "."],
        :P["This text contains a link to ", :Link[:href("http://www.google.com/"), "google"], "."],

        "#comment" => " a real-world sample, converted from Supply.rakudoc",
        :P["A tap on an ", :Code[:X[ "on demand"]]," supply will initiate the ",
           "production of values and tapping the supply again may result in a new set of values.",
           "For example, ", :Code[:X["Supply.interval"]], " produces a fresh ",
           "timer with the appropriate interval each time it is tapped."],
     ];

my PDF::Tags::Render $renderer .= new: :%role-map;
my PDF::API6 $pdf = $renderer.render($pdf-ast);
$pdf.save-as: "example.pdf";
```
