defmodule Exsmtp.Server do
  def start_link do
    session_options = [callbackoptions: [parse: true]]
    smtp_port = Application.get_env(:exsmtp, :port) #config(:smtp_port)
    smtp_server_options = [[port: smtp_port,
                            sessionoptions: session_options]]
    :gen_smtp_server.start(Exsmtp.Handler,
                           smtp_server_options)
  end
end
