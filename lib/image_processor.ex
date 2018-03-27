import FileUtils
import Enum, only: [member?: 2]


defmodule ImageProcessor do

  @supported_images ["jpg", "bmp", "png"]
  @min_image_height 10
  @min_image_width 10

  def process(img_url, folder) do
    with  {:ok, file_path} <- download(img_url, folder),
          {:ok, image} <- convert_to_image(file_path),
          {:ok, image} <- validate_size(image),
          {:ok} <- ImageConverter.convert_and_save(image) do
      IO.puts "Image #{img_url} processed successfully"
    else
      {:error, message} -> IO.puts "Image #{img_url} not processed - #{message}"
    end
  end

  def download(image_url, folder) do
      file_name = FileUtils.url_to_file_name(image_url)
      file_path = folder <> "/" <> file_name
      IO.puts "Downloading #{image_url}"

      case HTTPotion.get(image_url) do
        %HTTPotion.Response{status_code: code, body: body} when code>=200 and code<400 ->
          File.write(file_path, body)
          {:ok, file_path}
        %HTTPotion.Response{status_code: code} ->
          {:error, "Http return code #{code}"}
        %HTTPotion.ErrorResponse{message: message} ->
          {:error, message}
      end

    end

  def convert_to_image(file_path) do
    suffix = file_suffix(file_path)
    if member?(@supported_images, suffix) do
      image = file_path |> Mogrify.open |> Mogrify.verbose
      {:ok, image}
    else
      {:error, "Invalid image format #{suffix}"}
    end
  end

  def validate_size(image) do
      if image.width >= @min_image_width and image.height >= @min_image_height do
        {:ok, image}
      else
        {:error, "Image too small"}
      end
    end

end