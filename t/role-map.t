use Test;
use PDF::Tags::Render;
use PDF::API6;

plan 2;

my %role-map = (
    A => :Span[:TextDecorationType("Underline"), :B["foo"]],
    B => :Span[:A["bar"],]
);

my Pair:D $doc-ast =
    :Document[
             :Lang<en>,
             :H1["A Test Document with Recursion"],
         ];


lives-ok { PDF::Tags::Render.render($doc-ast, :%role-map) }
$doc-ast.value.push: (:A["urrgh"]);
dies-ok { PDF::Tags::Render.render($doc-ast, :%role-map) }
