defmodule KVS.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    registry = start_supervised!(KVS.Registry)
    %{registry: registry}
  end

  test "spawns buckets", %{registry: registry} do
    assert KVS.Registry.lookup(registry, "shopping") == :error

    KVS.Registry.create(registry, "shopping")
    assert {:ok, bucket} = KVS.Registry.lookup(registry, "shopping")

    KVS.Bucket.put(bucket, "milk", 1)
    assert KVS.Bucket.get(bucket, "milk") == 1
  end
end
