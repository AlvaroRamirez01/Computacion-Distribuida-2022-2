# Universidad Nacional Autonoma de Mexico
# Facultad de Ciencias
# Computación Distribuida 2022-2
# Practica #08
# Integrantes del equipo:
# * Marín Parra José Guadalupe de Jesús
# * Lázaro Pérez David Jonathan
# * Licona Aldo Daniel
# * Ramirez Lopez Alvaro

defmodule Anillos do

  #init es el estado incial por defecto con el map con :leader = nil y :from = nil
  def init do
    init_state = %{:leader => nil, :from => nil}
    message_receive(init_state)
  end

  # message_receive lee los mensajes recividos
  def message_receive(state) do
    receive do
      msge -> {:ok, new_state} = process_message(msge, state)
      message_receive(new_state)
    end
  end

  # process_message con :data recive un data y un state
  # donde se le da a cada proceso un id y se le indica quien es su vecino izquierdo
  def process_message({:data, data}, state) do
    %{:id => id, :left => izquierdo} = data
    state = Map.put(state, :id, id)
    state = Map.put(state, :left, izquierdo)
    {:ok, state}
  end

  # process_message con :init recibe un state
  # esta funcion hace que todos los procesos manden su id a su vecino izquierdo
  def process_message({:init}, state) do
    %{:id => id, :left => izquierdo} = state
    state = Map.put(state, :from, self())
    new_data = %{:new_id => id}
    send(izquierdo, {:send, new_data})
    {:ok, state}
  end

  # process_message con :sen recibe un data y un state
  # aqui se revisa si el id que recibe es menor a su id o si es mayor o si es igual
  # si el id que recibe es menor a su id se traga el id
  # si el id es mas grande que su id se lo envia a su vecino de la izquierda
  # si el id que recibe es igual a su id entonces se declara lider y manda un mesaje de
  # terminacion a su vecino izquierdo
  def process_message({:send, data}, state) do
    %{:id => id, :left => izquierdo} = state
    %{:new_id => new_id} = data
    new_data = %{:new_id => new_id}
    if new_id > id do
      send(izquierdo, {:send, new_data})
      {:ok, state}
    else
      if new_id == id do
        IO.puts "Yo #{inspect self()} soy el lider con id #{id}"
        state = Map.put(state, :leader, self())
        send(izquierdo, {:terminacion})
        {:ok, state}
      else
        {:ok, state}
      end
    end
  end

  # process_message con :terminacion recibe un state
  # donde si un proceso recibe :terminacion se declara como no lider y reenvia el mesaje :terminacion
  # a su vecino izquierdo 
  def process_message({:terminacion}, state) do
    %{:id => id, :left => izquierdo, :leader => lider} = state
    if(lider == self()) do
      {:ok, state}
    else
      IO.puts "Yo #{inspect self()} con id #{id} recibi terminacion, terminando como no lider"
      send(izquierdo, {:terminacion})
      {:ok,state}
    end
  end

end

# Ejemplo de uso

a = spawn(Anillos, :init, [])
b = spawn(Anillos, :init, [])
c = spawn(Anillos, :init, [])
d = spawn(Anillos, :init, [])

data_a = %{:id => 1, :left => b}
send(a, {:data, data_a})
data_b = %{:id => 2, :left => c}
send(b,{:data, data_b})
data_c = %{:id => 3, :left => d}
send(c,{:data, data_c})
data_d = %{:id => 4, :left => a}
send(d,{:data, data_d})

lista = [a,b,c,d]
Enum.map(lista, fn x -> send(x, {:init}) end)
