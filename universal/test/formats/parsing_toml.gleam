//// # Parsing TOML
//// 
//// Lustre is often used for complex stateful HTML applications, but it also
//// makes a great type-safe HTML templating system. It works on all targets.
////
//// ## Dependencies
////
//// - https://hex.pm/packages/tom

import gleam/dict
import gleeunit/should
import tom

pub fn main_test() {
  let toml =
    "
name = \"cookbook\"
version = \"1.0.0\"
licences = [\"Apache-2.0\"]
repository = { type = \"github\", user = \"gleam-lang\", repo = \"cookbook\" }

[dependencies]
gleam_stdlib = \">= 0.34.0 and < 2.0.0\"

[dev-dependencies]
gleeunit = \">= 1.0.0 and < 2.0.0\"
"

  // The `parse` function parses a string of TOML into a Gleam data structure
  let assert Ok(doc) = tom.parse(toml)

  // We've used `let assert` to crash if any of these functions fail. In a real
  // application or library you'd want to handle the results properly.

  // The resulting data structure is a Dict, and the TOML data type is not
  // opaque, so you can pattern match on them directly.
  let assert Ok(tom.String(name)) = dict.get(doc, "name")
  name |> should.equal("cookbook")

  // Alternatively some of the helper functions can be used to get nested values.
  let assert Ok(user) = tom.get_string(doc, ["repository", "user"])
  user |> should.equal("gleam-lang")
}
