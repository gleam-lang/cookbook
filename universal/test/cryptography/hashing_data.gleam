//// # Hashing data
//// 
//// The gleam_crypto library has a function for hashing data using various
//// popular hash algorithms. It works on all targets.
////
//// ## Dependencies
////
//// - https://hex.pm/packages/gleam_crypto

import gleam/bit_array
import gleam/crypto
import gleeunit/should

pub fn main_test() {
  let binary_data = <<1, 2, 3, 4, 5>>

  // The `hash` function can be used to hash a bit array of any size and shape.
  crypto.hash(crypto.Sha256, binary_data)
  |> should.equal(<<
    116, 248, 31, 225, 103, 217, 155, 76, 180, 29, 109, 12, 205, 168, 34, 120,
    202, 238, 159, 62, 47, 37, 213, 229, 163, 147, 111, 243, 220, 236, 96, 208,
  >>)

  // Commonly hashes are base64 encoded so they can be printed and shared easily
  // as text content.
  crypto.hash(crypto.Sha256, binary_data)
  |> bit_array.base64_encode(True)
  |> should.equal("dPgf4WfZm0y0HW0MzagieMrunz4vJdXlo5Nv89zsYNA=")

  // SHA256 is a sensible default, but other hash algorithms are available
  crypto.hash(crypto.Sha512, binary_data)
  |> bit_array.base64_encode(True)
  |> should.equal(
    "UFQLxK4xh1/Os4KUNMVePCtm3dcieog6O0zI9s2pZa0XErPuAAj5zuCNqT9SNMGnvw4lcO9W1lKA/+ppG5U+/g==",
  )
}
