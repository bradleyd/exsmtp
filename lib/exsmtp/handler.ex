defmodule Exsmtp.Handler do
  @behaviour :gen_smtp_server_session
  require Logger

  # SMTP codes
  @smtp_too_busy 421
  @smtp_requested_action_okay 250
  @smtp_mail_action_abort 552
  @smtp_unrecognized_command 500

  defmodule State do
    defstruct options: []
  end

  def init(hostname, _session_count, _client_ip_address, options) do
    banner = [hostname, " Exsmtp server"]
    state  = %State{options: options}
    {:ok, banner, state}
  end

  def handle_HELO(hostname, state) do
    :io.format("#{@smtp_requested_action_okay} HELO from #{hostname}~n")
    {:ok, 655360, state}
  end

  def handle_EHLO(_hostname, extensions, state) do
    {:ok, extensions, state}
  end

  def handle_MAIL(_sender, state) do
    {:ok, state}
  end

  def handle_RCPT(_to, state) do
    {:ok, state}
  end

  def handle_VRFY(_address, state) do
    {:error, "252 VRFY disabled by policy, no peeking", state}
  end

  def handle_DATA(_from, _to, "", state) do
    {:error, "#{@smtp_mail_action_abort} Message too small", state}
  end

  def handle_DATA(from, to, data, state) do
    unique_id = UUID.uuid4()
    Logger.debug("Message from #{from} to #{to} with body length #{byte_size(data)} queued as #{unique_id}")
    mail = parse_mail(data, state, unique_id)
    IO.inspect mail
    {:ok, unique_id, state}
  end

  def handle_MAIL_extension(extension, _state) do
    {:error, :io.format("Unknown MAIL FROM extension ~s~n", [extension])}
  end

  def handle_RCPT_extension(extension, _state) do
    {:error, :io.format("Unknown RCPT TO extension ~s~n", [extension])}
  end

  def handle_RSET(state) do
    state
  end

  def handle_other(verb, _args, state) do
    {["#{@smtp_unrecognized_command} Error: command not recognized : '", verb, "'"], state}
  end

  def terminate(reason, state) do
    {:ok, reason, state}
  end

  def code_change(_oldversion, state, _extra) do
    {:ok, state}
  end

  defp parse_mail(data, _state, _unique_id) do
    try do
      :mimemail.decode(data)
    rescue
      reason ->
        :io.format("Message decode FAILED with ~p:~n", [reason])
    end
  end
end
