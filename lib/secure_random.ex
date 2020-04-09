defmodule SecureRandom do
  @default_length 16

  def hex(n \\ @default_length) do
    random_bytes(n)
    |> Base.encode16(case: :lower)
    |> binary_part(0, n)
  end

  def base64(n \\ @default_length) do
    random_bytes(n)
    |> Base.encode64(padding: false)
    |> binary_part(0, n)
  end

  def urlsafe_base64(n \\ @default_length) do
    random_bytes(n)
    |> Base.url_encode64(padding: false)
    |> binary_part(0, n)
  end

  defp random_bytes(n) do
    :crypto.strong_rand_bytes(n)
  end
end
