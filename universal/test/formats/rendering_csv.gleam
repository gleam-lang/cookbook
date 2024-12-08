//// # Rendering CSV
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
  // If you have your data as a list of dicts then you can use the 
  // `from_dicts` function to create a CSV.
  // The headers will be taken automatically from the keys of all of the dicts.
  [
    dict.from_list([#("name", "Lucy"), #("score", "100"), #("colour", "Pink")]),
    dict.from_list([#("name", "Louis"), #("youtube", "@lpil"), #("score", "99")]),
  ]
  |> gsv.from_dicts(",", gsv.Unix)
  |> should.equal(
    "colour,name,score,youtube
Pink,Lucy,100,
,Louis,99,@lpil
",
  )

  // If you want to have control over the order of the columns than you can use
  // the `from_lists` function.
  [
    ["name", "score", "youtube", "colour"],
    ["Lucy", "100", "", "Pink"],
    ["Louis", "99", "@lpil", ""],
  ]
  |> gsv.from_lists(",", gsv.Unix)
  |> should.equal(
    "name,score,youtube,colour
Lucy,100,,Pink
Louis,99,@lpil,
",
  )

  // You can specify a different line ending and separator with either
  // function. Here a `;` is used to render TSV.
  [
    ["name", "score", "youtube", "colour"],
    ["Lucy", "100", "", "Pink"],
    ["Louis", "99", "@lpil", ""],
  ]
  |> gsv.from_lists(";", gsv.Unix)
  |> should.equal(
    "name;score;youtube;colour
Lucy;100;;Pink
Louis;99;@lpil;
",
  )
}
