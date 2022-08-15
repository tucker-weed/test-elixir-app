defmodule KVS.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KVS.Bucket.start_link([])
    %{opt1: bucket}
  end

  test "stores values by key", %{opt1: bucket} do
    assert KVS.Bucket.get(bucket, "milk") == :bad_key_error
    KVS.Bucket.put(bucket, "milk", 3)
    assert KVS.Bucket.get(bucket, "milk") == 3
  end

  test "deletes a value by key", %{opt1: bucket} do
    assert KVS.Bucket.delete(bucket, "fake_key") == :bad_key_error
    KVS.Bucket.put(bucket, "real_key", 22)
    assert KVS.Bucket.get(bucket, "real_key") == 22
    deleted_val = KVS.Bucket.delete(bucket, "real_key")
    assert deleted_val == 22
    assert KVS.Bucket.get(bucket, "real_key") == :bad_key_error
  end
end
