//// # Parsing CSV
//// 
//// The gsv package can be used to parse and render CSV on all targets.
////
//// ## Dependencies
////
//// - https://hex.pm/packages/gsv

import gleam/dict
import gleeunit/should
import gsv

pub fn main_test() {
  let csv =
    "name,colour,score
Lucy,Pink,100
Nubi,Black,100
"

  // The `to_lists` function can be used to parse a CSV to a list of lists
  gsv.to_lists(csv)
  |> should.be_ok
  |> should.equal([
    ["name", "colour", "score"],
    ["Lucy", "Pink", "100"],
    ["Nubi", "Black", "100"],
  ])

  // It may be easier to work with your data as dicts. If so you can use the
  // `to_dicts` function.
  gsv.to_dicts(csv)
  |> should.be_ok
  |> should.equal([
    dict.from_list([#("name", "Lucy"), #("colour", "Pink"), #("score", "100")]),
    dict.from_list([#("name", "Nubi"), #("colour", "Black"), #("score", "100")]),
  ])
}
