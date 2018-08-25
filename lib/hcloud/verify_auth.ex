defmodule HetznerCloud.VerifyAuth do
  @moduledoc """
    This is an extra module just to make sure your auth token is correct.
  """
  alias HetznerCloud.RequestError

  @api Application.get_env(:hcloud, :api)

  @doc """
    ##Example
        iex(1)> client = HetznerCloud.Auth.new("yourtoken")
        %HetznerCloud.Auth{
          token: "yourtoken"
        }
        iex(2)> HetznerCloud.VerifyAuth.verify(client)
        %{:ok, 200}
  """
  def verify(client) do
    %HetznerCloud.Auth{
      token: token
    } = client
    HTTPoison.request(:get, @api <> "ssh_keys", [], create_headers(token))
    |> handle_response()
  end

  @spec handle_response({atom(), map()}) :: tuple()
  defp handle_response({:error, struct}), do: {:error, "There was an error", struct}
  defp handle_response({:ok, %{body: _body, status_code: 200}}), do: {:ok, 200}
  defp handle_response({:ok, %{body: body, headers: headers, status_code: status_code}}) do
    %{
      "error" => %{
        "code" => code,
        "details" => details,
        "message" => message
      }
    } = Poison.decode!(body)
    error_struct = %RequestError{type: code, message: message, headers: headers, details: details, code: status_code}
    {:error, error_struct}
  end

  defp create_headers(token), do: [{"Authorization", "Bearer #{token}"}]
end