defmodule Analytics.RegistryHelper do
  def list do
    Registry.select(Analytics.Registry, [{{:"$1", :_, :_}, [], [:"$1"]}])
  end

  def get(key) do
    Registry.lookup(Analytics.Registry, key)
  end

  def list_and_get do
    Enum.map(list(), fn key ->
      [{pid, _}] = get(key)
      pid
    end)
  end
end
