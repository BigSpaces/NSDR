defmodule NsdrWeb.Mp3Plug do
  #use NsdrWeb, :controller
  import Plug.Conn
  @chunk_size 128

  def init(opts), do: opts


  def call(conn, _opts) do
    IO.inspect(File.ls(), label: "LS: ")

    conn = conn
    |> send_chunked(200)
    |> put_resp_header("content-type", "audio/mpeg")

    mp3 = "/priv/static/assets/drone.mp3"

    File.stream!(mp3, [], @chunk_size)
    |> Enum.into(conn)
  end

end
