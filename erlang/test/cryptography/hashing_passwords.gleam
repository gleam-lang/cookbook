//// # Hashing passwords
//// 
//// The argus library has bindings to the standard C implementation of the
//// argon2 password hashing algorithm. This is the best option for password
//// hashing presently. Currently it only supports Erlang.
////
//// Because argus depends on C code you will need to ensure that the computers
//// you compile your project on have a C compiler and Make installed.
////
//// ## Dependencies
////
//// - https://hex.pm/packages/argus

import argus
import gleeunit/should

pub fn main_test() {
  let password = "blink182"

  // The `hash` function can be used to hash a password with a salt.
  //
  // A SALT MUST NEVER BE REUSED. Generate a new one for each password you
  // need to hash.
  let assert Ok(hashes) =
    argus.hasher()
    |> argus.hash(password, argus.gen_salt())

  // The `verify` function is used to check a password against a hash.
  argus.verify(hashes.encoded_hash, password)
  |> should.equal(Ok(True))

  argus.verify(hashes.encoded_hash, "some-other-password")
  |> should.equal(Ok(False))

  // Password hashing is a (deliberately) expensive operation.
  // If you are hashing passwords frequently in your test suite you may want to
  // configure the hasher to be less expensive to run.
  //
  // NEVER DO THIS OUTSIDE OF TESTS. You must do your research before setting
  // any of these values and ensure you know what you are doing.
  let assert Ok(_hashes) =
    argus.hasher()
    |> argus.algorithm(argus.Argon2id)
    |> argus.time_cost(3)
    |> argus.memory_cost(12_228)
    |> argus.parallelism(1)
    |> argus.hash_length(32)
    |> argus.hash("password", argus.gen_salt())
}
