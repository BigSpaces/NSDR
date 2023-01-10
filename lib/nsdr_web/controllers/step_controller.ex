defmodule NsdrWeb.StepController do
  use NsdrWeb, :controller
  alias Nsdr.Newsletter
  alias Nsdr.Newsletter.Subscriber

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
     changeset = Newsletter.change_subscriber(%Subscriber{})
     render(conn, "play.html", [incoming_params: incoming_params, fileurl: fileurl, changeset: changeset])
  end

end
