defmodule Bread.Dump do
  @dump_path "./tmp/testing"

  def dump(term, path \\ @dump_path) do
    bin = term |> :erlang.term_to_binary()
    File.write!(path, bin)
  end
end
