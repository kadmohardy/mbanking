defmodule Mbanking.Utils.Math do
  @moduledoc false
  def generate_code(n) do
    "~#{n}..0B"
    |> :io_lib.format([(10 |> :math.pow(n) |> round() |> :rand.uniform()) - 1])
    |> List.to_string()
  end
end
