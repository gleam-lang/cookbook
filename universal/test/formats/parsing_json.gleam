//// # Parsing JSON
////
//// The gleam_json library can be used to decode JSON.
////
//// ## Dependencies
////
//// - https://hex.pm/packages/gleam_json

import gleam/dict
import gleam/dynamic
import gleam/json
import gleeunit/should

type User(name, age, is_admin) {
  User(name, age, is_admin)
}

pub fn main_test() {
  // Basic string key-value pair
  "{\"name\": \"cookbook\"}"
  |> json.decode(dynamic.dict(dynamic.string, dynamic.string))
  |> should.equal(Ok(dict.from_list([#("name", "cookbook")])))

  // String key-value pair with list of integers
  "{\"scores\": [1, 2, 3]}"
  |> json.decode(dynamic.dict(dynamic.string, dynamic.list(of: dynamic.int)))
  |> should.equal(Ok(dict.from_list([#("scores", [1, 2, 3])])))

  // Custom decoder
  let decoder =
    dynamic.decode3(
      User,
      dynamic.field("name", dynamic.string),
      dynamic.field("age", dynamic.int),
      dynamic.field("is_admin", dynamic.bool),
    )
  "{\"name\": \"Alice\", \"age\": 42, \"is_admin\": true}"
  |> json.decode(decoder)
  |> should.equal(Ok(User("Alice", 42, True)))
}
