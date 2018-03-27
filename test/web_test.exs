import Web

defmodule WebTest do
  use ExUnit.Case
  doctest Web

  test "convert_relative_links converts relative links" do
    assert convert_relative_links(["images/cat.jpg","images/dog.png"],"http://www.images.com") ==
                  ["http://www.images.com/images/cat.jpg",
                  "http://www.images.com/images/dog.png"]
  end

end
