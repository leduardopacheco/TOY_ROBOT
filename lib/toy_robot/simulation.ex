defmodule ToyRobot.Simulation do
  alias ToyRobot.{Robot, Simulation, Table}
  defstruct [:table, :robot]

  @doc """
  Simula o posicionamento do robô no tabuleiro
  """
  def place(table, %{x: x, y: y, facing: facing}) do
    robot = %Robot{x: x, y: y, facing: facing}

    if Table.valid_position?(table, robot) do
      {:ok, %Simulation{table: table, robot: robot}}
    else
      {:error, :invalid_placement}
    end
  end

  @doc """
  Movimenta o robô um espaço da direção que ele está apontando, a menos que essa posição esteja além dos limites do tabuleiro.
  """
  def move(nil), do: nil

  def move(%Simulation{robot: robot, table: table} = simulation) do
    moved = Robot.move(robot)
  
    if Table.valid_position?(table, moved) do
      {:ok, %Simulation{simulation | robot: moved}}
    else
      {:error, :at_table_boundary}
    end
  end
  

  @doc """
  Gira o robô no sentido anti-horário (esquerda)
  """
  def turn_left(%Simulation{robot: robot} = simulation) do
    new_robot = Robot.turn_left(robot)
    {:ok, %Simulation{simulation | robot: new_robot}}
  end

  @doc """
  Gira o robô no sentido horário (direita)
  """
  def turn_right(%Simulation{robot: robot} = simulation) do
    new_robot = Robot.turn_right(robot)
    {:ok, %Simulation{simulation | robot: new_robot}}
  end

  @doc """
  Exibir a posição atual do robô
  """
  def report(%Simulation{robot: robot}), do: robot
end
