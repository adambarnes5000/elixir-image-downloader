import Enum, only: [map: 2]

defmodule ImageDownloader do

  def main(args) do
    if length(args) != 2 do
      IO.puts "Usage: Downloader [URL of website for images] [Output folder]"
    else
      try do
        [url, folder] = args
        IO.puts "Extracting images from #{url} into #{folder}"
        Web.extract_image_urls(url)
          |> map(async_download(folder))
          |> map(&Task.await/1)
      rescue
        e in HTTPotion.HTTPError -> IO.puts("An HTTP error occurred: " <> e.message)
       end
    end
  end

  def async_download(folder) do
    fn(img_url) -> Task.async(ImageProcessor, :process, [img_url, folder]) end
  end

end
