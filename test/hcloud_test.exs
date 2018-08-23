defmodule HetznerCloudTest do
  use ExUnit.Case
  doctest HetznerCloud

  test "greets the world" do
    assert HetznerCloud.hello() == :world
  end
end
