import Mogrify

defmodule ImageConverter do

  @image_sizes    [100,220,320]
  @image_formats  ["png","jpg"]

  def convert_and_save(image) do
    for size <- [100,220,320], format <- ["png","jpg"] do
      convert_and_save(image, size, format)
    end
    {:ok}
  end

  def convert_and_save(image, size, format) do
    image |> resize_to_limit("#{size}x#{size}") |> format(format) |> save([path: get_path(image.path, size, format)])
  end

  def get_path(orig_path, size, format) do
    suffix = FileUtils.file_suffix(orig_path)
    String.replace_suffix(orig_path, "." <> suffix, "_#{size}.#{format}")
  end

end