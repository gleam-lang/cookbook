//// # Generate UUIDs
//// 
//// Here the youid package is used to generate UUIDs of different types.
////
//// The library supports only the Erlang target currently.
////
//// ## Dependencies
////
//// - https://hex.pm/packages/youid

import youid/uuid

pub fn main_test() {
  // UUID version 4 is the most commonly used, it is completely random.
  // It can be generated using the v4 function
  let uuid_v4 = uuid.v4()

  // UUIDs are a binary format, but often you want them in the less compact
  // string format so they can be printed. This can be done with the
  // `to_string` function.
  let _ = uuid.to_string(uuid_v4)

  // They can also be converted a bit-array. This is a constant time operation,
  // unlike converting to a string.
  let _ = uuid.to_bit_array(uuid_v4)

  // If you want to generate the UUID in string format you can use the
  // `v4_string` convenience function. 
  let _ = uuid.v4_string()

  // Another useful UUID version is v7. It is not entirely random as it
  // incorporates the time of generation into the UUID.
  //
  // This is useful for when you wish to be able to extract the time from the
  // UUID, or when you want UUIDs to be orderable from oldest to newest. This
  // could have performance benefits when using it as a primary key in a
  // relational database over the random v4.
  let _ = uuid.v7()
  let _ = uuid.v7_string()
}
