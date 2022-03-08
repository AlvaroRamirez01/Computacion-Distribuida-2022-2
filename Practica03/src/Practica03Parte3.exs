# Universidad Nacional Autonoma de Mexico
# Facultad de Ciencias
# Computación Distribuida 2022-2
# Practica #03
# Integrantes del equipo:
# * Marín Parra José Guadalupe de Jesús
# * Lázaro Pérez David Jonathan
# * Licona Aldo Daniel
# * Ramirez Lopez Alvaro

defmodule Practica03Parte3 do
  # Este metodo recive una tupla, si la key de la tupla es :pid entonces regresa Hola, (pid del proceso), soy: (pid que manden con self)
  # Si la key de la tupla es :ok entonces regresa el mensaje que le pasan
  # Si la key de la tupla es :nok entonces regresa el mensaje concatenado consigo mismo.

  def mensaje1 do
    receive do
      {:pid, x} -> IO.puts("Hola, #{inspect x}, soy: #{inspect self()}")
      {:ok, msg} -> IO.puts("#{msg}")
      {:nok, ms2} -> IO.puts("#{ms2}#{ms2}")
    end
  end
end