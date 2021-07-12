defmodule Canvas do
  @defaults [fg: "black", bg: "white", font: "Arial"]

  def draw_text(text, options \\ []) do
    options = Keyword.merge(@defaults, options)
    IO.puts("Drawing text #{inspect(text)}")
    IO.puts("Foreground: #{options[:fg]}")
    IO.puts("Background: #{Keyword.get(options, :bg)}")
    IO.puts("Font: #{Keyword.get(options, :font)}")
    IO.puts("Pattern: #{Keyword.get(options, :pattern, "solid")}")
    IO.puts("Style: #{inspect(Keyword.get_values(options, :style))}")
    IO.inspect(options)
  end
end
