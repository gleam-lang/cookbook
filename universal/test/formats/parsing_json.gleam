//// # Parsing JSON
////
//// The gleam_json library can be used to decode JSON.
////
//// ## Dependencies
////
//// - https://hex.pm/packages/gleam_json

import decode/zero
import gleam/json
import gleeunit/should

pub type User {
  User(name: String, age: Int, is_admin: Bool)
}

pub fn main_test() {
  // Simple types
  let decoder = {
    use name <- zero.field("name", zero.string)
    zero.success(name)
  }
  "{\"name\": \"cookbook\"}"
  |> json.decode(zero.run(_, decoder))
  |> should.equal(Ok("cookbook"))

  // Lists
  let decoder = {
    use scores <- zero.field("scores", zero.list(zero.int))
    zero.success(scores)
  }
  "{\"scores\": [1, 2, 3]}"
  |> json.decode(zero.run(_, decoder))
  |> should.equal(Ok([1, 2, 3]))

  // Records
  let decoder = {
    use name <- zero.field("name", zero.string)
    use age <- zero.field("age", zero.int)
    use is_admin <- zero.field("is_admin", zero.bool)
    zero.success(User(name:, age:, is_admin:))
  }
  "{\"name\": \"Alice\", \"age\": 42, \"is_admin\": true}"
  |> json.decode(zero.run(_, decoder))
  |> should.equal(Ok(User("Alice", 42, True)))
}
