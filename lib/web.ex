import Enum, only: [map: 2]
import String, only: [starts_with?: 2]
import Map, only: [get: 2]

defmodule Web do

  def extract_image_urls(url) do
    HTTPotion.get(url) |> get(:body) |> Floki.find("img") |> Floki.attribute("src") |> convert_relative_links(url)

    # convert_relative_links(Floki.attribute(Floki.find((HTTPotion.get(url).response),"img"),"src"),url)
  end

  def convert_relative_links(paths, baseurl) do
    map(paths, fn(path) ->
      if starts_with?(path, "http") do
            path
          else
            baseurl <> "/" <> path
          end
     end)
  end


end