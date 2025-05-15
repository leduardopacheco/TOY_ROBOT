defmodule ToyRobot.Simulation do
  alias ToyRobot.{Robot, Simulation, Table}
  defstruct [:table, :robot]

  @doc """
  Simula o posicionamento do robô no tabuleiro

  ## Exemplo

  ### Quando o robô é posicionado em uma posição válida

      iex> alias ToyRobot.{Robot, Table, Simulation}
      iex> table = %Table{x_max: 4, y_max: 4}
      iex> Simulation.place(table, %{x: 0, y: 0, facing: :north})
      {:ok, %Simulation{table: %Table{x_max: 4, y_max: 4}, robot: %Robot{x: 0, y: 0, facing: :north}}}

  ### Quando o robô é posicionado em uma posição inválida

      iex> alias ToyRobot.{Robot, Table, Simulation}
      iex> table = %Table{x_max: 4, y_max: 4}
      iex> Simulation.place(table, %{x: 6, y: 0, facing: :north})
      {:error, :invalid_placement}
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

  ## Exemplo

  ### Um movimento válido

      iex> alias ToyRobot.{Robot, Table, Simulation}
      iex> table = %Table{x_max: 4, y_max: 4}
      iex> simulation = %Simulation{
      ...>   table: table,
      ...>   robot: %Robot{x: 0, y: 0, facing: :north}
      ...> }
      iex> Simulation.move(simulation)
      {:ok, %Simulation{table: %Table{x_max: 4, y_max: 4}, robot: %Robot{x: 0, y: 1, facing: :north}}}

  ### Um movimento inválido

      iex> alias ToyRobot.{Robot, Table, Simulation}
      iex> table = %Table{x_max: 4, y_max: 4}
      iex> simulation = %Simulation{
      ...>   table: table,
      ...>   robot: %Robot{x: 0, y: 4, facing: :north}
      ...> }
      iex> Simulation.move(simulation)
      {:error, :at_table_boundary}
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

  ## Exemplo

      iex> alias ToyRobot.{Robot, Table, Simulation}
      iex> table = %Table{x_max: 4, y_max: 4}
      iex> simulation = %Simulation{
      ...>   table: table,
      ...>   robot: %Robot{x: 0, y: 0, facing: :north}
      ...> }
      iex> Simulation.turn_left(simulation)
      {:ok, %Simulation{table: %Table{x_max: 4, y_max: 4}, robot: %Robot{x: 0, y: 0, facing: :west}}}
  """
  def turn_left(%Simulation{robot: robot} = simulation) do
    new_robot = Robot.turn_left(robot)
    {:ok, %Simulation{simulation | robot: new_robot}}
  end

  @doc """
  Gira o robô no sentido horário (direita)

  ## Exemplo

      iex> alias ToyRobot.{Robot, Table, Simulation}
      iex> table = %Table{x_max: 4, y_max: 4}
      iex> simulation = %Simulation{
      ...>   table: table,
      ...>   robot: %Robot{x: 0, y: 0, facing: :north}
      ...> }
      iex> Simulation.turn_right(simulation)
      {:ok, %Simulation{table: %Table{x_max: 4, y_max: 4}, robot: %Robot{x: 0, y: 0, facing: :east}}}
  """
  def turn_right(%Simulation{robot: robot} = simulation) do
    new_robot = Robot.turn_right(robot)
    {:ok, %Simulation{simulation | robot: new_robot}}
  end

  @doc """
  Exibir a posição atual do robô

  ## Exemplo

      iex> alias ToyRobot.{Robot, Table, Simulation}
      iex> table = %Table{x_max: 4, y_max: 4}
      iex> simulation = %Simulation{
      ...>   table: table,
      ...>   robot: %Robot{x: 0, y: 0, facing: :north}
      ...> }
      iex> Simulation.report(simulation)
      %Robot{x: 0, y: 0, facing: :north}
  """
  def report(%Simulation{robot: robot}), do: robot
end
