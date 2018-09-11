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

  test "test unauthorized client" do
    use_cassette "when your token is wrong" do
      {:error, %HetznerCloud.RequestError{code: status_code, type: type}} = HetznerCloud.VerifyAuth.verify(@client)
      assert status_code == 401
      assert type == "unauthorized"
    end
  end
end
