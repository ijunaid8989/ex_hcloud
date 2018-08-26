defmodule HetznerCloudTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest HetznerCloud

  @client HetznerCloud.Auth.new(System.get_env("HCLOUD_ACCESS_TOKEN"))

  setup_all do
    HTTPoison.start
  end

  test "test auth client" do
    use_cassette "test your auth token" do
      assert HetznerCloud.VerifyAuth.verify(@client) == {:ok, 200}
    end
  end
end
