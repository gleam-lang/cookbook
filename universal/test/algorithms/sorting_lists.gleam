//// # Sorting lists
//// 
//// The Gleam standard library provides functions for sorting lists and
//// ordering core Gleam data types.
////
//// ## Dependencies
////
//// - https://hex.pm/packages/gleam_stdlib

import gleam/float
import gleam/int
import gleam/list
import gleam/order
import gleam/string
import gleeunit/should

pub fn main_test() {
  // The `list.sort` function takes an additional argument, a function which is
  // used to determine which of any two elements in a list are bigger or
  // smaller.
  [54, 6, 34, 92, 4]
  |> list.sort(int.compare)
  |> should.equal([4, 6, 34, 54, 92])

  // By convention this function is called `compare` and modules for given data
  // types may define this function.
  ["Tom", "Dick", "Harry"]
  |> list.sort(string.compare)
  |> should.equal(["Dick", "Harry", "Tom"])

  // Lists are sorted from smallest to largest. If you want largest to smallest
  // then you can swap the arguments to the compare function.
  [3.4, 1.55, 10.4, 8.1]
  |> list.sort(fn(a, b) { float.compare(b, a) })
  |> should.equal([10.4, 8.1, 3.4, 1.55])

  // You can implement your own compare funtion using the `Order` type from the
  // `gleam/order` module. Here is a compare function which sorts strings, but
  // considers the string `zz-top` to be the smallest for some reason.
  ["electric six", "the spice girls", "abba", "zz-top", "grlwood"]
  |> list.sort(fn(a, b) {
    case a, b {
      "zz-top", _ -> order.Lt
      _, "zz-top" -> order.Gt
      a, b -> string.compare(a, b)
    }
  })
  |> should.equal([
    "zz-top", "abba", "electric six", "grlwood", "the spice girls",
  ])
}
