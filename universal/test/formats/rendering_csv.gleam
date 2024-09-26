//// # Rendering CSV
//// 
//// The gsv package can be used to parser and render CSV on all targets.
////
//// ## Dependencies
////
//// - https://hex.pm/packages/gsv

import gleam/dict
import gleeunit/should
import gsv

pub fn main_test() {
  let data = [
    dict.from_list([#("name", "Lucy"), #("score", "100"), #("colour", "Pink")]),
    dict.from_list([
      #("name", "Isaac"),
      #("youtube", "@IsaacHarrisHolt"),
      #("score", "99"),
    ]),
  ]

  gsv.from_dicts(data, ",", gsv.Unix)
  |> should.equal(
    "colour,name,score,youtube
Pink,Lucy,100,
,Isaac,99,@IsaacHarrisHolt
",
  )
}
