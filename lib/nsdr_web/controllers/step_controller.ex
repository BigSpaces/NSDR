defmodule NsdrWeb.StepController do
  use NsdrWeb, :controller

  def step1(conn, _params) do
    IO.puts("HELLO THERE")
    render(conn, "index.html")
  end

  def step2(conn, incoming_params) do
    render(conn, "step2.html", incoming_params: incoming_params)
  end

  def step3(conn, incoming_params) do

    render(conn, "step3.html", incoming_params: incoming_params)
  end

  def play(conn, incoming_params) do
     IO.inspect(incoming_params, label: "PARAMS")
      fileurl = case incoming_params do
        %{"background" => "silence", "choice1" => "nidra", "time" => "short"} -> "/audio/drone.mp3"

      end

     render(conn, "play.html", [incoming_params: incoming_params, fileurl: fileurl])
  end

end
