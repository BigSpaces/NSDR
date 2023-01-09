defmodule NsdrWeb.Mp3Controller do
  use NsdrWeb, :controller
#  import Plug.Conn
@chunk_size 128

  def index(conn, _params) do
    # conn = conn
    # |> send_chunked(200)
    # |> put_resp_header("content-type", "audio/mpeg")

    # mp3 = "/priv/static/assets/drone.mp3"

    # File.stream!(mp3, [], @chunk_size)
    # |> Enum.into(conn)

    render(conn, "index.html", [mykey: "My MP3"])
  end

end
