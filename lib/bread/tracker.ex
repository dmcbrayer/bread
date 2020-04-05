defmodule Bread.Tracker do
  use Agent

  @doc """
  Starts a new tracker map for a user
  """
  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end)
  end

  def bucket_state(bucket) do
    Agent.get(bucket, fn state -> state end)
  end

  @doc """
  Gets a value from the bucket by key
  """
  def get(bucket, key) do
    Agent.get(bucket, fn state ->
      Map.get(state, key)
    end)
  end

  @doc """
  Puts the `value` for the given `key` in the `bucket`.
  """
  def put(bucket, key, value) do
    Agent.update(bucket, fn state ->
      Map.put(state, key, value)
    end)
  end

  def tick(bucket) do
    Agent.update(bucket, fn state ->
      Map.put(state, :time, state.time + 1)
    end)
  end
end
