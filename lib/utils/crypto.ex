defmodule Mbanking.Utils.Crypto do
  @moduledoc false

  def encrypt_map_item(map, key) do
    if Map.has_key?(map, key) do
      map
      |> Map.replace!(key, Cipher.encrypt(map[key]))
    else
      map
    end
  end
end
