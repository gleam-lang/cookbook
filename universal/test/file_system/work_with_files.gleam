//// # Read and write files
//// 
//// Here the simplifile package is used to work with files, which
//// works on both the Erlang and JavaScript targets, including several popular
//// JavaScript runtimes.
////
//// The library blocks on JavaScript, so if you want to work with files in a
//// concurrent JavaScript based application then you may want to use a
//// JavaScript specific file system library.
////
//// ## Dependencies
////
//// - https://hex.pm/packages/simplifile

import gleam/list
import gleam/string
import simplifile

pub fn main_test() {
  // The `delete_all` function can be used to delete multiple files or directories.
  // We are using it first here to reset the tmp directory to a known state.
  let assert Ok(_) = simplifile.delete_all(["tmp"])

  // We've used `let assert` to crash if any of these functions fail. In a real
  // application or library you'd want to handle the results properly.

  // The `create_directory` function creates directories.
  let assert Ok(_) = simplifile.create_directory("tmp")

  // It returns an error if the directory already exists.
  let assert Error(simplifile.Eexist) = simplifile.create_directory("tmp")

  // The `create_directory_all` function can be used instead if you don't care
  // if it already exists.
  let assert Ok(_) = simplifile.create_directory_all("tmp")

  // It will also create any missing parent directories
  let assert Ok(_) =
    simplifile.create_directory_all("tmp/one/very/nested/directory")

  // `create_file` can create a new empty file.
  let assert Ok(_) = simplifile.create_file("tmp/file.txt")
  let assert Ok(_) =
    simplifile.create_file("tmp/one/very/nested/directory/file.txt")

  // It fails if the parent directory doesn't exist
  let assert Error(simplifile.Enoent) =
    simplifile.create_file("tmp/unknown/file.txt")

  // `write` can write string content to file
  let assert Ok(_) =
    simplifile.write(to: "tmp/file1.txt", contents: "Hello, Joe!")

  // If the file doesn't exist it will be created
  let assert Ok(_) =
    simplifile.write(to: "tmp/file2.txt", contents: "Hello, Mike!")

  // `write_bits` can be used to write bit array data to a file.
  let assert Ok(_) = simplifile.write_bits("tmp/file.bin", <<0, 255>>)

  // `read` can be used to read string contents from a file.
  let assert Ok("Hello, Joe!") = simplifile.read("tmp/file1.txt")

  // It will fail if the contents are not unicode.
  let assert Error(simplifile.NotUtf8) = simplifile.read("tmp/file.bin")

  // `read_bits` can be used to read bit array content from files
  let assert Ok(<<0, 255>>) = simplifile.read_bits("tmp/file.bin")

  // `copy_file` can be used to copy files
  let assert Ok(_) = simplifile.copy_file("tmp/file1.txt", "tmp/file3.txt")

  // `get_files` gets all files within a directory and its subdirectories
  let assert Ok(files) = simplifile.get_files("tmp")
  let assert [
    "tmp/file.bin",
    "tmp/file.txt",
    "tmp/file1.txt",
    "tmp/file2.txt",
    "tmp/file3.txt",
    "tmp/one/very/nested/directory/file.txt",
  ] = list.sort(files, string.compare)

  // `describe_error` can be used to get a textual description of an error
  let assert "Input/output error" = simplifile.describe_error(simplifile.Eio)
}
