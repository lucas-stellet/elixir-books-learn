defmodule Metex.Worker do
  @moduledoc false

  def temperature_of(location) do
    result =
      url_for(location)
      |> HTTPoison.get()
      |> parse_response()

    case result do
      {:ok, temp} ->
        "#{location}: #{temp}ºC"

      :error ->
        "#{location} not found"
    end
  end

  def loop do
    receive do
      {sender_pid, location} ->
        send(sender_pid, {:ok, temperature_of(location)})

      _ ->
        IO.puts("don't know how to process this message")
    end

    loop()
  end

  defp url_for(location) do
    location = URI.encode(location)

    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{apikey()}"
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body
    |> Jason.decode!()
    |> compute_temperature()
  end

  defp parse_response(_), do: :error

  defp compute_temperature(json) do
    try do
      temp =
        (json["main"]["temp"] - 273.15)
        |> Float.round(1)

      {:ok, temp}
    rescue
      _ -> :error
    end
  end

  defp apikey, do: "8ebb197ddd9be1d00b127a764006693c"
end
