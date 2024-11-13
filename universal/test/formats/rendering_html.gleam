//// # Rendering HTML
//// 
//// Lustre is often used for complex stateful HTML applications, but it also
//// makes a great type-safe HTML templating system. It works on all targets.
////
//// ## Dependencies
////
//// - https://hex.pm/packages/lustre

import gleam/string
import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html

pub fn main_test() {
  // Lustre provides functions for HTML elements and attributes that can be used
  // to construct an HTML document.
  //
  let document =
    html.html([], [
      html.head([], [html.title([], "Greetings!")]),
      html.body([], [
        html.h1([attribute.id("greeting")], [
          html.text("Hello, Joe! Hello, Mike!"),
        ]),
      ]),
    ])

  // The document can be converted to a string.
  document
  |> element.to_document_string
  |> should.equal(normalise_test_html(
    "
    <!doctype html>
    <html>
    <head>
      <title>Greetings!</title>
    </head>
    <body>
      <h1 id=\"greeting\">Hello, Joe! Hello, Mike!</h1>
    </body>
    </html>
    ",
  ))

  // Or you can render a fragment without a doctype.
  html.input([
    attribute.for("name"),
    attribute.type_("text"),
    attribute.value("Lucy"),
  ])
  |> element.to_string
  |> should.equal("<input for=\"name\" type=\"text\" value=\"Lucy\">")
}

//
// Lustre has excellent documentation. Check it out for more information
// https://hexdocs.pm/lustre/
//

fn normalise_test_html(html: String) -> String {
  // We write the text expectations in a pretty-printed format to make it easier
  // to understand, but Lustre produces minified HTML for performance and
  // compactness, so this functional normalises it so they match.
  html
  |> string.replace("  ", "")
  |> string.replace("\n", "")
  |> string.replace("<html>", "\n<html>")
}
