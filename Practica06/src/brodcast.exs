# Universidad Nacional Autonoma de Mexico
# Facultad de Ciencias
# Computación Distribuida 2022-2
# Practica #06
# Integrantes del equipo:
# * Marín Parra José Guadalupe de Jesús
# * Lázaro Pérez David Jonathan
# * Licona Aldo Daniel
# * Ramirez Lopez Alvaro

defmodule Brodcast do

  # inica, inicia un proceso y un estao inicial {:procesado => false, :raiz => false, :palabra => palabra} que es estado_inicial
  # y recibe una palabra y la guardara en un map con la llave :palabra
  # y se lo manda a recibe_mensaje

  def inicia(palabra) do
    estado_inicial = %{:procesado => false, :raiz => false, :palabra => palabra}
    recibe_mensaje(estado_inicial)
  end

  # recibe_mensaje, recibe un estado que es un map
  # y hace match con {:ok, nuevo_estado} con lo que recibe de procesa_mensaje mandandole el mensaje y estado recibidos

  def recibe_mensaje(estado) do
    receive do
      mensaje -> {:ok, nuevo_estado} = procesa_mensaje(mensaje, estado)
      recibe_mensaje(nuevo_estado)
    end
  end

  # procesa_mensaje con {:id, id} recibe un map estado y un id
  # el cual se agrega al map estado con la llave :id
  # y regresa {:ok, estado} donde estado ya esta modificado

  def procesa_mensaje({:id, id}, estado) do
    estado = Map.put(estado, :id, id)
    {:ok, estado}
  end

  # procesa_mensaje con {:vecinos, vecinos} recibe un map estado y una lista con sus vecinos
  # entonces agrega esa lista al map estado con la llave :vecinos
  # y regresa {:ok, estado} donde estado ya esta modificado

  def procesa_mensaje({:vecinos, vecinos}, estado) do
    estado = Map.put(estado, :vecinos, vecinos)
    {:ok, estado}
  end

  # procesa_mensaje con {:inicia} recibe un estado el cual se le manda a conexion
  # y despues estado sera lo que dvuelva conexion
  # y regresa {:ok, estado} donde estado ya esta modificado

  def procesa_mensaje({:inicia}, estado) do
    estado = conexion(estado)
    {:ok, estado}
  end

  # procesa_mensaje con {:raiz} recibe un estado y designa al proceso como la raiz
  # entonces guarda ese cambio en el map estado
  # y regresa {:ok, estado} donde estado ya esta modificado

  def procesa_mensaje({:raiz}, estado) do
    estado = Map.put(estado, :raiz, true)
    {:ok, estado}
  end

  # procesa_mensaje con {:mensaje, n_id} recibe un map estado y un id
  # el cual sera enviado junto con estado a conexion
  # y el estado que devuelva conexion sera ahora estado
  # y regresa {:ok, estado} donde estado ya esta modificado

  def procesa_mensaje({:mensaje, n_id}, estado) do
    estado = conexion(estado, n_id)
    {:ok, estado}
  end


  # conexion recibe un emap estado y un id y id lo coloca como nil por omision
  # pregunta si el estado recibido es la raiz y si no lo hemos procesado, si esto pasa
  # entonces cada uno de sus vecinos le manda su id y marcamos como procesado.
  # si el id no es la raiz y no esta procesado, entonces dice que mensaje recibe de su padre
  # y le dice a cada uno de sus hijos que haga lo mismo.

  def conexion(estado, n_id \\ nil) do
    %{:id => id, :vecinos => vecinos, :procesado => procesado, :raiz => raiz, :palabra => palabra} = estado
    if raiz and (not procesado) do
      Enum.map(vecinos, fn vecino -> send vecino, {:mensaje, id} end)
      Map.put(estado, :procesado, true)
    else
      if n_id != nil and (not procesado) do
        IO.puts "Soy el id #{id} y mi padre #{(n_id)} me pasó #{palabra}"
        Enum.map(vecinos, fn vecino -> send vecino, {:mensaje, id} end)
        Map.put(estado, :procesado, true)
      else
        estado
      end
    end
  end

end

a = spawn(Brodcast, :inicia, ['hola'])
b = spawn(Brodcast, :inicia, ['hola'])
c = spawn(Brodcast, :inicia, ['hola'])
d = spawn(Brodcast, :inicia, ['hola'])
e = spawn(Brodcast, :inicia, ['hola'])
f = spawn(Brodcast, :inicia, ['hola'])
g = spawn(Brodcast, :inicia, ['hola'])
h = spawn(Brodcast, :inicia, ['hola'])

send(a, {:id, 1})
send(b, {:id, 2})
send(c, {:id, 3})
send(d, {:id, 4})
send(e, {:id, 5})
send(f, {:id, 6})
send(g, {:id, 7})
send(h, {:id, 8})

send(a, {:vecinos, [e,b]})
send(b, {:vecinos, [c,d]})
send(c, {:vecinos, []})
send(d, {:vecinos, [f,g]})
send(e, {:vecinos, []})
send(f, {:vecinos, [h]})
send(g, {:vecinos, []})
send(h, {:vecinos, []})

send(a, {:raiz})

send(a, {:inicia})

Process.sleep(1000)
