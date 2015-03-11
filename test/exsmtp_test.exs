defmodule ExsmtpTest do
  use ExUnit.Case

  setup do
    result = case Exsmtp.start([], []) do
      {:error, {:already_started, pid}} ->
        {:ok, pid: pid}
      {:ok, pid} ->
        {:ok, pid: pid}
    end
    result
  end

  test "smtp server accepts a message correctly" do
    result = :gen_smtp_client.send({ "me@test.com", ["to@example.com"], "Subject: Testing in Exuinit\r\nFrom: The Dude \r\nTo: Awesomesauce \r\n\r\nThis is the email body"}, [relay: "127.0.0.1", port: 2525])
    assert {:ok, pid} = result
  end
end
