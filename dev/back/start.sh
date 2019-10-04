#!/usr/bin/env elixir

defmodule Script do

  def main(args) do
    IO.puts "Hello, Elixir!"
    print_args(args)
  end

  def print_args([]), do: :ok
  
  def print_args(args) do
    IO.puts("\nArgs:")
    args
    |> Enum.each(fn s -> IO.puts("  " <> s) end)
  end
end

Script.main(System.argv)