defmodule HetznerCloud.Request do

  alias HetznerCloud.RequestError

  @api Application.get_env(:hcloud, :api)

  def request(:get, path, token) do
    HTTPoison.request(:get, @api <> path, [], create_headers(token))
    |> handle_response()
  end

  @spec handle_response({atom(), map()}) :: tuple()
  def handle_response({:error, struct}), do: {:error, "There was an error", struct}
  def handle_response({:ok, %{body: body, status_code: 200}}), do: {:ok, body}
  def handle_response({:ok, %{body: body, headers: headers, status_code: status_code}}) do
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

  def create_headers(token), do: [{"Authorization", "Bearer #{token}"}]
end