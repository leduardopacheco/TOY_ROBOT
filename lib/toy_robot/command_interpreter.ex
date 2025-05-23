defmodule ToyRobot.CommandInterpreter do
  @spec interpret(any()) :: list()

  @doc """
  Interpreta comandos de uma lista de comandos, preparando-os para serem executados

  ## Exemplo

  ### Comandos válidos

      iex> alias ToyRobot.CommandInterpreter
      ToyRobot.CommandInterpreter
      iex> commands = ["PLACE 1,2,NORTH", "MOVE", "LEFT", "RIGHT", "REPORT"]
      iex> CommandInterpreter.interpret(commands)
      [
        {:place, %{x: 1, y: 2, facing: :north}},
        :move,
        :turn_left,
        :turn_right,
        :report
      ]

  ### Comandos inválidos

      iex> alias ToyRobot.CommandInterpreter
      iex> commands = ["SPIN", "TWIRL", "EXTERMINATE"]
      iex> CommandInterpreter.interpret(commands)
      [
        {:invalid, "SPIN"},
        {:invalid, "TWIRL"},
        {:invalid, "EXTERMINATE"}
      ]
  """
  def interpret(commands) do
    Enum.map(commands, &do_interpret/1)
  end

  defp do_interpret("MOVE"), do: :move
  defp do_interpret("LEFT"), do: :turn_left
  defp do_interpret("RIGHT"), do: :turn_right
  defp do_interpret("REPORT"), do: :report

  defp do_interpret("PLACE " <> rest) do
    case String.split(rest, ",") do
      [x_str, y_str, dir_str] ->
        with {x, ""} <- Integer.parse(x_str),
             {y, ""} <- Integer.parse(y_str),
             facing <- parse_facing(dir_str) do
          {:place, %{x: x, y: y, facing: facing}}
        else
          _ -> {:invalid, "PLACE " <> rest}
        end

      _ ->
        {:invalid, "PLACE " <> rest}
    end
  end

  defp do_interpret(command), do: {:invalid, command}

  defp parse_facing("NORTH"), do: :north
  defp parse_facing("SOUTH"), do: :south
  defp parse_facing("EAST"), do: :east
  defp parse_facing("WEST"), do: :west
  defp parse_facing(_), do: nil
end
