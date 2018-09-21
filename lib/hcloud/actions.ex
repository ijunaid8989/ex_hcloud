defmodule HetznerCloud.Actions do
  @moduledoc """
    This module will cover both action endpoint available on https://docs.hetzner.cloud/#actions
  """
  defstruct actions: nil, meta: nil

  import HetznerCloud.Request

  @doc """
    This will fetch all the action performed by the token holder's account
    ##Example
        iex(1)> client = HetznerCloud.Auth.new("yourtoken")
        %HetznerCloud.Auth{
          token: "yourtoken"
        }
        iex(2)> HetznerCloud.Actions.actions(client)
        %HetznerCloud.Actions{
          actions: [
            %HetznerCloud.Action{
              command: "create_server",
              error: nil,
              finished: "2018-08-07T12:13:52+00:00",
              id: 4342913,
              progress: 100,
              resources: [%{"id" => 942959, "type" => "server"}],
              started: "2018-08-07T12:13:33+00:00",
              status: "success"
            }
          ],
          meta: %HetznerCloud.Meta.Pagination{
            last_page: 1,
            next_page: nil,
            page: 1,
            per_page: 25,
            previous_page: nil,
            total_entries: 11
          }
        }
  """
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

  @doc """
    This will fetch an action performed by the token holder's account with action ID

    ##Example

        iex(1)> client = HetznerCloud.Auth.new("yourtoken")
        %HetznerCloud.Auth{
          token: "yourtoken"
        }
        iex(2)> HetznerCloud.Actions.actions(client, "4342913")
        %HetznerCloud.Action{
          command: "create_server",
          error: nil,
          finished: "2018-08-07T12:13:52+00:00",
          id: 4342913,
          progress: 100,
          resources: [%{"id" => 942959, "type" => "server"}],
          started: "2018-08-07T12:13:33+00:00",
          status: "success"
        }
  """
  def action(client, id) do
    %HetznerCloud.Auth{
      token: token
    } = client

    with {:ok, body} <- request(:get, "actions/#{id}", token) do
      decoded_body = Poison.decode! body
      action = decoded_body["action"]

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
    else
      {:error, error} ->
        {:error, error}
    end
  end
end
