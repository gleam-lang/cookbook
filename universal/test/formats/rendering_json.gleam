//// # Generate JSON
//// 
//// The gleam_json package can be used to generate JSON. It works on any
//// target.
////
//// ## Dependencies
////
//// - https://hex.pm/packages/gleam_json

import gleam/json
import gleam/string
import gleeunit/should

pub fn main_test() {
  // The `gleam/json` module has a function for each different type of data in
  // a JSON document. e.g. `bool`, `string`, `int`, etc.
  //
  // The `preprocessed_array` function is used for arrays made from list
  // that already contain JSON data.
  //
  let document =
    json.object([
      #(
        "bookstore",
        json.preprocessed_array([
          json.object([
            #("genre", json.string("Technology")),
            #("title", json.string("Introduction to JSON")),
            #("author", json.string("Kwame Nkrumah")),
          ]),
          json.object([
            #("genre", json.string("Programming")),
            #("title", json.string("Learning Gleam")),
            #("author", json.string("Mei Wong")),
          ]),
        ]),
      ),
    ])

  // The document can be converted to a string
  document
  |> json.to_string
  |> should.equal(
    "
{
  \"bookstore\":[
    {
      \"genre\":\"Technology\",
      \"title\":\"Introduction to JSON\",
      \"author\":\"Kwame Nkrumah\"
    },
    {
      \"genre\":\"Programming\",
      \"title\":\"Learning Gleam\",
      \"author\":\"Mei Wong\"
    }
  ]
}
  "
    |> string.replace("  ", "")
    |> string.replace("\n", ""),
  )

  // If you have a collection of items and you wish to map over each of them to
  // make JSON then you can use the `array` function rather than the
  // `preprocessed_array` function.
  let directions = ["North", "East", "South", "West"]
  json.object([
    #(
      "directions",
      json.array(directions, fn(direction) {
        json.object([#("name", json.string(direction))])
      }),
    ),
  ])
  |> json.to_string
  |> should.equal(
    "
{
  \"directions\":[
    {\"name\":\"North\"},
    {\"name\":\"East\"},
    {\"name\":\"South\"},
    {\"name\":\"West\"}
  ]
}
  "
    |> string.replace("  ", "")
    |> string.replace("\n", ""),
  )
}
