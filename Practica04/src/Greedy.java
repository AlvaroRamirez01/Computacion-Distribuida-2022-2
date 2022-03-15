import java.util.*;

  /** 
  Universidad Nacional Autonoma de Mexico
  Facultad de Ciencias
  Computación Distribuida 2022-2
  Practica #04
  Integrantes del equipo:
  * Marín Parra José Guadalupe de Jesús
  * Lázaro Pérez David Jonathan
  * Licona Aldo Daniel
  * Ramirez Lopez Alvaro 
  **/

public class Greedy{

  // tiempo inicial del evento
  public int inicio;
  // tiempo final del evento
  public int finale;
  // nombre del evento
  public String nombre;

  //Constructor que crea un evento
  public Greedy(int inicio, int finale,String nombre){
    this.inicio = inicio;
    this.finale = finale;
    this.nombre = nombre;
  }

  // Regresa el tiempo inicial del evento
  public int getInicio(){
    return this.inicio;
  }
  // Regresa el tiempo final del evento
  public int getFinal(){
    return this.finale;
  }
  // Regresa el nombre del evento
  public String getNombre(){
    return this.nombre;
  }

  //Metodo que toma el primer evento y como es el que termina primero
  // verifica que otros eventos son compatibles y los agrega.
  public void elige(Greedy[] arreglo){
    ArrayList<String> lista = new ArrayList<String>();
    int comparador = arreglo[0].getFinal();
    lista.add(arreglo[0].getNombre());
    for (int i = 1; i < arreglo.length ;i++ ) {
      if(comparador <= arreglo[i].getInicio()){
        lista.add(arreglo[i].getNombre());
        comparador = arreglo[i].getFinal();
      }
    }

    for (String evento :lista ) {
      System.out.println(evento);
    }
  }


  //Metodo que ordena los eventos de tal forma que el que termine primero es el que
  //esta primero y el que termina ultimo sera el ultimo.
  public void ordena(Greedy[] arreglo){
    int temporal = 0;
    Greedy evento;
    for (int i = 0; i < arreglo.length; i++) {
        for (int j = 1; j < (arreglo.length - i); j++) {
            if (arreglo[j - 1].getFinal() > arreglo[j].getFinal()) {
                temporal = arreglo[j - 1].getFinal();
                evento = arreglo[j - 1];
                arreglo[j - 1] = arreglo[j];
                arreglo[j] = evento;
            }
        }
    }
    elige(arreglo);

    }

}
