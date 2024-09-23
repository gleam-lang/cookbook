//// # Read environment variables
//// 
//// The envoy package is used to work with environment variables. This package
//// works on both Erlang and JavaScript targets.
//// 
//// ## Dependencies
//// 
//// - https://hex.pm/packages/envoy

import envoy
import gleam/dict

pub fn main_test() {
  // The `unset` function can be used to unset environment variables. We are
  // using it first here to reset the PORT environment variable to a known
  // state.
  envoy.unset("PORT")

  // We've used `let assert` to crash if any of these functions fail. In a real
  // application or library you'd want to handle the results properly.

  // The `get` function gets environment variables by name. It returns an error
  // if the environment variable is not set.
  let assert Error(Nil) = envoy.get("PORT")

  // The `set` function sets environment variables.
  envoy.set("PORT", "8080")

  // The `get` function returns `Ok` if the environment variable is set.
  let assert Ok("8080") = envoy.get("PORT")

  // The `all` function can be used to get a Dict of all set environment
  // variables.
  let environment_variables = envoy.all()
  let assert Ok("8080") = dict.get(environment_variables, "PORT")
}
