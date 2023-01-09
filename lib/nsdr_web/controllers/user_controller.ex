defmodule NsdrWeb.UserController do
  use NsdrWeb, :controller

  def signup(a, b) do
    IO.inspect(a, label: "A")
    IO.inspect(b, label: "B")
    {:ok, b}
  end

end
