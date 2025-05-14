defmodule ToyRobot.Robot do
  defstruct x: 0, y: 0, facing: :north
  alias ToyRobot.Robot

  @moduledoc """
  Documentação para o ToyRobot.Robot
  """

  @doc """
  Movimenta o robô uma posição para a direção que o mesmo está apontando.

  ## exemplo
    iex> alias ToyRobot.Robot
    ToyRobot.Robot
    iex> robot = %Robot{y: 0, facing: :north}
    %Robot{y: 0, facing: :north}
    iex> robot |> Robot.move
    %Robot{y: 1, x: 0, facing: :north}
  """
  def move(%Robot{facing: :north} = robot), do: %Robot{robot | y: robot.y + 1}
  def move(%Robot{facing: :south} = robot), do: %Robot{robot | y: robot.y - 1}
  def move(%Robot{facing: :east} = robot), do: %Robot{robot | x: robot.x + 1}
  def move(%Robot{facing: :west} = robot), do: %Robot{robot | x: robot.x - 1}

  @doc """
  Gira o robô no sentido anti-horário (esquerda)
  """
  def turn_left(%Robot{facing: :north} = robot), do: %Robot{robot | facing: :west}
  def turn_left(%Robot{facing: :west} = robot), do: %Robot{robot | facing: :south}
  def turn_left(%Robot{facing: :south} = robot), do: %Robot{robot | facing: :east}
  def turn_left(%Robot{facing: :east} = robot), do: %Robot{robot | facing: :north}

  @doc """
  Gira o robô no sentido horário (direita)
  """
  def turn_right(%Robot{facing: :north} = robot), do: %Robot{robot | facing: :east}
  def turn_right(%Robot{facing: :east} = robot), do: %Robot{robot | facing: :south}
  def turn_right(%Robot{facing: :south} = robot), do: %Robot{robot | facing: :west}
  def turn_right(%Robot{facing: :west} = robot), do: %Robot{robot | facing: :north}
end
