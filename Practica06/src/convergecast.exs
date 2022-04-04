# Universidad Nacional Autonoma de Mexico
# Facultad de Ciencias
# Computación Distribuida 2022-2
# Practica #06
# Integrantes del equipo:
# * Marín Parra José Guadalupe de Jesús
# * Lázaro Pérez David Jonathan
# * Licona Aldo Daniel
# * Ramirez Lopez Alvaro

defmodule Convergecast do

  # la funcion inicia como su nombre lo dice inicia un proceso con un estado inicial que es estado_inicial
  def inicia do
    estado_inicial = %{:raiz => false, :padre => false, :palabras => []}
    recibe_mensaje(estado_inicial)
  end

  # recibe_mensaje lee los mensajes que le mandan y hace match con el map {:ok, nuevo_estado}
  # de lo que sale de la funcion procesa_mensaje
  def recibe_mensaje(estado) do
    receive do
      mensaje -> {:ok, nuevo_estado} = procesa_mensaje(mensaje, estado)
      recibe_mensaje(nuevo_estado)
    end
  end

  # procesa_mensaje con {:id, id} recibe un map estado y un id
  # el cual sera agregado al map estado con la llave :id
  # y regresara {:ok, estado} donde estado ya esta modificado

  def procesa_mensaje({:id, id}, estado) do
    estado = Map.put(estado, :id, id)
    {:ok,estado}
  end

  # procesa_mensaje con {:vecinos, vecinos} recibe un map estado y una lista de vecinos
  # la cual sera agregada al map estado con la llave :vecinos
  # y regresara {:ok, estado} donde estado ya esta modificado

  def procesa_mensaje({:vecinos, vecinos}, estado) do
    estado = Map.put(estado, :vecinos, vecinos)
    {:ok,estado}
  end

  # procesa_mensaje con {:padre, padre} recibe un map estado y un pid padre
  # entonces agrega padre al map estado con la llave :padre
  # y regresara {:ok, estado} donde estado ya esta modificado

  def procesa_mensaje({:padre, padre}, estado) do
    estado = Map.put(estado, :padre, padre)
    {:ok,estado}
  end

  # procesa_mensaje con {:respuestas} recibe un map estado
  # donde agregara al map estado el numero de respuestas con la llave :respuetas que inicia en 0
  # y regresara {:ok, estado} donde estado ya esta modificado

  def procesa_mensaje({:respuestas}, estado) do
    estado = Map.put(estado, :respuestas, 0)
    {:ok,estado}
  end

  # procesa_mensaje con {:raiz, estado} recibe un map estado
  # al cual aignara a ese pid como raiz y lo agregara al map estado con la llave :raiz y valor true
  # y regresara {:ok, estado} donde estado ya esta modificado

  def procesa_mensaje({:raiz}, estado) do
    estado = Map.put(estado, :raiz, true)
    {:ok,estado}
  end

  # procesa_mensaje {:inicia, lista_palabras}  recibe un map estado y una listas lista_palabras
  # la cual es la lista con las palabras, la cual sera eneviada junto a el estado recibido a convergecast_mayor
  # y lo que se obtenga de convergecast_mayor sera el nuevo estado
  # y regresara {:ok, estado} donde estado ya esta modificado

  def procesa_mensaje({:inicia, lista_palabras}, estado) do
    estado = convergecast_mayor(estado, lista_palabras)
    {:ok, estado}
  end

  # procesa_mensaje {:mensaje, mensaje} recibe un map estado y un mensaje
  # como recibió un mensaje entonces aumenta el numero de pesuestas en una unidad
  # y lo agrega al estado y despues agrega el mensaje a su lista palabras done guarda todos los mensajes recibidos
  # y guarda ese cambio en el map estado
  # y regresara {:ok, estado} donde estado ya esta modificado

  def procesa_mensaje({:mensaje, mensaje}, estado) do
    %{:respuestas => resp, :palabras => palabras} = estado
    estado = Map.put(estado, :respuestas, resp + 1)
    estado = Map.put(estado, :palabras, palabras ++ mensaje)

    estado = convergecast_mayor(estado, mensaje)
    {:ok,estado}
  end

  # convergecast_mayor recibe un map estado y una lista lista_palabras que es un mensaje
  # primero pregunta si el estado es la raiz si es la raiz entonces calcula la cadena mas grande de la lista recibida
  # si no es la raiz entonces manda la lista recibida a su padre

  def convergecast_mayor(estado, lista_palabras) do
    %{:id => id, :vecinos => vecinos, :raiz => raiz,
      :respuestas => resp, :padre => papi, :palabras => palabras} = estado

    if raiz do
      if (resp == (length vecinos)) do
        mayor = lista(palabras, lista_palabras)
        IO.puts "La cadena de mayor tamaño es #{mayor}"
        estado
      end
      estado

    else
      if (resp == (length vecinos) - 1) do
        mapeo = Enum.map(lista_palabras, fn x -> "#{x}," end)
        IO.puts("No soy raiz (#{id}) y mi papá(#{inspect papi}) recibirá la lista con #{mapeo}")
        send(papi, {:mensaje, lista_palabras})
      else
        estado
      end
    end
  end


  # lista se encarga de devolver la palabra mas grande que contiene una lista de cadenas

  def lista([],palabra) do
    palabra
  end

  def lista([nil|h],palabra) do
    if length(palabra) > length(h) do
      palabra
    else
      h
    end
  end

  def lista([x | xs],palabra) do
    if length(palabra) > length(x) do
      lista(xs,palabra)
    else
      palabra = x
      lista(xs,palabra)
    end
  end

end


a = spawn(Convergecast, :inicia, [])
b = spawn(Convergecast, :inicia, [])
c = spawn(Convergecast, :inicia, [])
d = spawn(Convergecast, :inicia, [])
e = spawn(Convergecast, :inicia, [])
f = spawn(Convergecast, :inicia, [])
g = spawn(Convergecast, :inicia, [])
h = spawn(Convergecast, :inicia, [])
i = spawn(Convergecast, :inicia, [])
j = spawn(Convergecast, :inicia, [])
k = spawn(Convergecast, :inicia, [])
l = spawn(Convergecast, :inicia, [])
m = spawn(Convergecast, :inicia, [])

send(a, {:id, 1})
send(b, {:id, 2})
send(c, {:id, 3})
send(d, {:id, 4})
send(e, {:id, 5})
send(f, {:id, 6})
send(g, {:id, 7})
send(h, {:id, 8})
send(i, {:id, 9})
send(j, {:id, 10})
send(k, {:id, 11})
send(l, {:id, 12})
send(m, {:id, 13})

send(a, {:vecinos, [b,c,m]})
send(b, {:vecinos, [a,d]})
send(c, {:vecinos, [a,e,f]})
send(d, {:vecinos, [b,k,l]})
send(e, {:vecinos, [c]})
send(f, {:vecinos, [c,g,h]})
send(g, {:vecinos, [f]})
send(h, {:vecinos, [f,i,j]})
send(i, {:vecinos, [h]})
send(j, {:vecinos, [h]})
send(k, {:vecinos, [d]})
send(l, {:vecinos, [d]})
send(m, {:vecinos, [a]})

send(a, {:respuestas})
send(b, {:respuestas})
send(c, {:respuestas})
send(d, {:respuestas})
send(e, {:respuestas})
send(f, {:respuestas})
send(g, {:respuestas})
send(h, {:respuestas})
send(i, {:respuestas})
send(j, {:respuestas})
send(k, {:respuestas})
send(l, {:respuestas})
send(m, {:respuestas})


send(b, {:padre, a})
send(c, {:padre, a})
send(d, {:padre, b})
send(e, {:padre, c})
send(f, {:padre, c})
send(g, {:padre, f})
send(h, {:padre, f})
send(i, {:padre, h})
send(j, {:padre, h})
send(k, {:padre, d})
send(l, {:padre, d})
send(m, {:padre, a})


send(a, {:raiz})

send(k, {:inicia, ['amigos','siu','hola']})
send(l, {:inicia, ['sillon','perro']})
send(e, {:inicia, ['ademas','ufas']})
send(g, {:inicia, ['holamundo']})
send(i, {:inicia, ['david','jose']})
send(j, {:inicia, ['celular','todo']})
send(m, {:inicia, ['compu-mundo-hiper-mega-red']})
