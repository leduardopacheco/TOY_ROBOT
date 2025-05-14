defmodule ToyRobot.CommandRunner do
  alias ToyRobot.{Simulation, Table}

  def run(commands), do: run(commands, nil)

  def run([{:place, placement} | rest], nil) do
    table = %Table{}
    case Simulation.place(table, placement) do
      {:ok, simulation} -> run(rest, simulation)
      {:error, _} -> run(rest, nil)
    end
  end

  def run([{:place, placement} | rest], simulation) do
    case Simulation.place(simulation.table, placement) do
      {:ok, new_sim} -> run(rest, new_sim)
      {:error, _} -> run(rest, simulation)
    end
  end

  def run([:move | rest], simulation) do
    case Simulation.move(simulation) do
      {:ok, updated} -> run(rest, updated)
      {:error, _} -> run(rest, simulation)
      nil -> run(rest, simulation)
    end
  end  

  def run([:turn_left | rest], simulation) do
    {:ok, updated} = Simulation.turn_left(simulation)
    run(rest, updated)
  end

  def run([:turn_right | rest], simulation) do
    {:ok, updated} = Simulation.turn_right(simulation)
    run(rest, updated)
  end

  def run([:report | rest], simulation) do
    robot = Simulation.report(simulation)
    IO.puts("O robô está na posição (#{robot.x}, #{robot.y}) apontando para o #{translate_direction(robot.facing)}")
      run(rest, simulation)
  end

  def run([{:invalid, _command} | rest], simulation), do: run(rest, simulation)
  def run([_ | rest], nil), do: run(rest, nil)
  def run([], simulation), do: simulation
  defp translate_direction(:north), do: "norte"
  defp translate_direction(:south), do: "sul"
  defp translate_direction(:east), do: "leste"
  defp translate_direction(:west), do: "oeste"

end
