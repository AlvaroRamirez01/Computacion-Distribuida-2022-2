# Universidad Nacional Autonoma de Mexico
# Facultad de Ciencias
# Computación Distribuida 2022-2
# Practica #04
# Integrantes del equipo:
# * Marín Parra José Guadalupe de Jesús
# * Lázaro Pérez David Jonathan
# * Licona Aldo Daniel
# * Ramirez Lopez Alvaro

defmodule GetBack do

# Funcion drop recibe un tupla de 3 parametros {sender, figure, datos} y manda un mensaje a sender con el area de la figura
# que recibió como llave.
# ejemplo de como se usa y como funciona.
# pid1 = spawn(GetBack, :drop, [])
# PID<0.120.0>
# send(pid1, {self(), :trapezoid, %{:b1 => 20.4, :b2 => 14.5, :h => 4.1}})
# {#PID<0.106.0>, :trapezoid, %{b1: 20.4, b2: 14.5, h: 4.1}}
# flush()
# {:trapezoid, %{b1: 20.4, b2: 14.5, h: 4.1}, 71.54499999999999}
# :ok


  def drop do
    receive do
      {sender, figure, datos} ->
        send(sender, {figure, datos, area(figure, datos)})
        drop()
      end
  end

  # La funcion area con la llave :circle calcula el area de un circulo, y datos es un map donde la llave :radio es el radio del circulo
  # Por ejemplo %{:radio => 16.8}
  defp area(:circle, datos) do
    :math.pi * (datos[:radio] * datos[:radio])
  end

  # La funcion area con la llave :triangle calcula el area de un triangulo, y datos es un map donde la llave :base es la base del triangulo
  # y la llave :altura es la altura del triangulo
  # Por ejemplo %{:base => 20, :altura => 6}
  defp area(:triangle, datos) do
    (datos[:base] * datos[:altura]) / 2
  end

  # La funcion area con la llave :rectangle calcula el area de un rectangulo, y datos es un map donde la llave :l es el largo del rectangulo
  # y la llave :w es lo ancho del rectangulo.
  # Por ejemplo %{:w => 4, :l => 8}
  defp area(:rectangle, datos) do
    datos[:l] * datos[:w]
  end

  # La funcion area con la llave :trapezoid calcula el area de un trapezoide, y datos es un map donde la llave :b1 es la base 1 del trapezoide
  # y la llave :b2 es la base 2 del trapezoide y la llave :h es la altura del trapezoide
  # Por ejemplo %{:b1 => 20.4, :b2 => 14.5 , :h => 4.1}
  defp area(:trapezoid, datos) do
    ((datos[:b1] + datos[:b2]) / 2) * datos[:h]
  end
end
