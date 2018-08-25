defmodule HetznerCloud.Auth do
  @moduledoc """
    This module is to initialize your auth client for every request.

    ###Example
        iex(1)> client = HetznerCloud.Auth.new("yourtoken")
          %HetznerCloud.Auth{
            token: "yourtoken"
          }
  """
  defstruct token: nil

  @type token :: %{token: binary}
  @type t :: %__MODULE__{token: token}

  @spec new() :: t
  def new(), do: %__MODULE__{}

  @spec new(token) :: t
  def new(token) do
    %__MODULE__{token: token}
  end
end
