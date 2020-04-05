defmodule Bread.Tracker do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def value do
    Agent.get(__MODULE__, fn v -> v end)
  end

  def increment do
    Agent.update(__MODULE__, fn v -> v + 1 end)
  end

  def decrement do
    Agent.update(__MODULE__, fn v -> v - 1 end)
  end
end
