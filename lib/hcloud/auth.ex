defmodule HetznerCloud.Auth do
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
