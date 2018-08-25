defmodule HetznerCloud.Actions do
  defstruct actions: nil, meta: nil

  import HetznerCloud.Request

  def actions(client) do
    %HetznerCloud.Auth{
      token: token
    } = client

    with {:ok, body} <- request(:get, "actions", token) do
      decoded_body = Poison.decode! body
      actions =
        decoded_body["actions"]
        |> Enum.map(fn action ->
          %HetznerCloud.Action{
            id: action["id"],
            command: action["command"],
            status: action["status"],
            progress: action["progress"],
            started: action["started"],
            finished: action["finished"],
            resources: action["resources"],
            error: action["error"]
          }
        end)

      %{
        "pagination" => %{
          "last_page" => last_page,
          "next_page" => next_page,
          "page" => page,
          "per_page" => per_page,
          "previous_page" => previous_page,
          "total_entries" => total_entries
        }
      } = decoded_body["meta"]
      meta =
        %HetznerCloud.Meta.Pagination{
          last_page: last_page,
          next_page: next_page,
          page: page,
          per_page: per_page,
          previous_page: previous_page,
          total_entries: total_entries
        }

        %HetznerCloud.Actions{
          actions: actions,
          meta: meta
        }
    else
      {:error, error} ->
        {:error, error}
    end
  end
end
