//// # Rendering XML
//// 
//// The xmb package can be used to generate XML. It works on any target.
////
//// ## Dependencies
////
//// - https://hex.pm/packages/xmb
//// - https://hex.pm/packages/gleam_stdlib

import gleam/string
import gleam/string_builder
import gleeunit/should
import xmb.{x}

pub fn main_test() {
  // The `x` function is used to define an XML element. It takes 3 arguments
  // 1. The name of the element
  // 2. A list of attributes
  // 3. A list of child nodes
  //
  // The `text` function is used to define text nodes.
  //
  let document =
    x("bookstore", [], [
      x("book", [#("genre", "Technology")], [
        x("title", [], [xmb.text("Introduction to XML")]),
        x("author", [], [xmb.text("Kwame Nkrumah")]),
      ]),
      x("book", [#("genre", "Programming")], [
        x("title", [], [xmb.text("Learning Gleam")]),
        x("author", [], [xmb.text("Mei Wong")]),
      ]),
    ])

  // The document can be converted to a string builder, which can be converted
  // to a string if needed.
  let string = [document] |> xmb.render |> string_builder.to_string

  string
  |> should.equal(
    "
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<bookstore>
    <book genre=\"Technology\">
        <title>Introduction to XML</title>
        <author>Kwame Nkrumah</author>
    </book>
    <book genre=\"Programming\">
        <title>Learning Gleam</title>
        <author>Mei Wong</author>
    </book>
</bookstore>
  "
    |> string.replace("  ", "")
    |> string.replace("\n", ""),
  )

  // If you want to render just a fragment (so no `<?xml ...` declaration) you
  // can use the `render_fragment` function.
  let string =
    x("book", [#("genre", "Technology")], [
      x("title", [], [xmb.text("Introduction to XML")]),
      x("author", [], [xmb.text("Kwame Nkrumah")]),
    ])
    |> xmb.render_fragment
    |> string_builder.to_string

  string
  |> should.equal(
    "
<book genre=\"Technology\">
    <title>Introduction to XML</title>
    <author>Kwame Nkrumah</author>
</book>
  "
    |> string.replace("  ", "")
    |> string.replace("\n", ""),
  )
}
