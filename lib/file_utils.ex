defmodule FileUtils do
  @moduledoc false

  def url_to_file_name(url) do
    url |> String.split("/") |> Enum.reverse |> hd
  end

  def file_suffix(full_path) do
    full_path |> String.split(".") |> Enum.reverse |> hd
  end

end