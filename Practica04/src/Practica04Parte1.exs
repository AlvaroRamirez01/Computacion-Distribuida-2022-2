# Universidad Nacional Autonoma de Mexico
# Facultad de Ciencias
# Computación Distribuida 2022-2
# Practica #04
# Integrantes del equipo:
# * Marín Parra José Guadalupe de Jesús
# * Lázaro Pérez David Jonathan
# * Licona Aldo Daniel
# * Ramirez Lopez Alvaro

defmodule ParaTodos do

# Funcion lee el mensaje recibido y imprime el mensaje "Hola el proceso que 
# es, soy el proceso que le mandan"
  def mensaje1 do
    receive do
      {:pid, x} -> IO.puts("Hola, #{inspect x}, soy: #{inspect self()}")
    end
  end

# spawnear realiza spawn de n procesos y los guarda en una lista
# y devuelve la lista con los procesos spawneados.

# Ejemplo de como se usa.
# ParaTodos.pawnear(3)
# regresa [#PID<0.122.0>, #PID<0.123.0>, #PID<0.124.0>]

  def spawnear(n) do
    lista = Enum.map(1..n, fn x -> spawn(ParaTodos, :mensaje1, []) end)
    lista
  end

# mandar recibe la lista que regresa la funcion spawnear con los n procesos y 
# les envia el mensaje {:pid, self()} a cada uno.

# Ejemplo de como se usa:
# lista = ParaTodos.pawnear(3)
# regresa [#PID<0.122.0>, #PID<0.123.0>, #PID<0.124.0>]
# ParaTodos.mandar(lista)
# Hola, #PID<0.106.0>, soy: #PID<0.122.0>
# Hola, #PID<0.106.0>, soy: #PID<0.123.0>
# Hola, #PID<0.106.0>, soy: #PID<0.124.0>
# [pid: #PID<0.106.0>, pid: #PID<0.106.0>, pid: #PID<0.106.0>]

# O tambien se puede hacer así
# ParaTodos.mandar(ParaTodos.spawnear(5))
# Hola, #PID<0.106.0>, soy: #PID<0.116.0>
# Hola, #PID<0.106.0>, soy: #PID<0.117.0>
# Hola, #PID<0.106.0>, soy: #PID<0.118.0>
# Hola, #PID<0.106.0>, soy: #PID<0.119.0>
# Hola, #PID<0.106.0>, soy: #PID<0.120.0>
# [
#   pid: #PID<0.106.0>,
#   pid: #PID<0.106.0>,
#   pid: #PID<0.106.0>,
#   pid: #PID<0.106.0>,
#   pid: #PID<0.106.0>
# ]

  def mandar(l) do
    Enum.map(l, fn x -> send(x,{:pid, self()}) end)
  end
end
