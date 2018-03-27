import FileUtils

defmodule FileUtilsTest do
  use ExUnit.Case
  doctest FileUtils

  test "url_to_file_name works correctly" do
    assert url_to_file_name("http://www.images.com/jpgs/cat.jpg") == "cat.jpg"
  end

  test "file_suffix works correctly" do
      assert file_suffix("http://www.images.com/jpgs/cat.jpg") == "jpg"
  end

end
