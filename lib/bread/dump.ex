defmodule Bread.Dump do
  @dump_path "./tmp/testing"

  def dump(term) do
    bin = term |> :erlang.term_to_binary()
    File.write!(@dump_path, bin)
  end
end
