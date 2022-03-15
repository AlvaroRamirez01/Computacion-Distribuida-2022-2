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

public class Practica04Parte3{
  
  public static void main(String[] args) {

    Scanner sc = new Scanner(System.in);
    int inicio;
    int finale;
    System.out.println("Ingresa con numero enteros el inicio y final del evento A por favor.");
    inicio = sc.nextInt();
    finale = sc.nextInt();
    Greedy evento1 = new Greedy(inicio,finale,"Evento A");
    System.out.println("Ingresa con numero enteros el inicio y final del evento B por favor.");
    inicio = sc.nextInt();
    finale = sc.nextInt();
    Greedy evento2 = new Greedy(inicio,finale,"Evento B");
    System.out.println("Ingresa con numero enteros el inicio y final del evento C por favor.");
    inicio = sc.nextInt();
    finale = sc.nextInt();
    Greedy evento3 = new Greedy(inicio,finale,"Evento C");
    System.out.println("Ingresa con numero enteros el inicio y final del evento D por favor.");
    inicio = sc.nextInt();
    finale = sc.nextInt();
    Greedy evento4 = new Greedy(inicio,finale,"Evento D");

    Greedy[] arreglo = new Greedy[4];

    arreglo[0] = evento1;
    arreglo[1] = evento2;
    arreglo[2] = evento3;
    arreglo[3] = evento4;

    System.out.println("Los eventos que puedes tomar son:");
    evento1.ordena(arreglo);
  }
}
