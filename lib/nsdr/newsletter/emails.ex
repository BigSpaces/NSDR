defmodule Newsletter.Emails do
  import Swoosh.Email

  @sender_email "zak@nidra.online"
  @sender_name "Zak"

  def welcome(user) do
    new()
    |> to({user.name, user.email})
    |> from({@sender_name, @sender_email})
    |> subject("Ya eres parte de NSDR")
    |> html_body("<h1>Hola #{user.name}, ahora puedes practicar meditaciones personalizadas</h1>")
    |> text_body("Hola #{user.name}\n, espero que te haya gustado la aplicación")
  end
end
