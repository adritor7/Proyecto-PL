package microaplicacionpl;

import java.util.Scanner;

public class MicroAplicacionPL {
    public static void main(String[] args) {
        /* Indicamos la frencuencia de una cadena dentro de otra,teniendo
           en cuenta que pueden ser subcadenas de la cadena principal.
        */
        System.out.println ("Por favor introduzca una oración por teclado:");
        String continente = "";
        Scanner entradaEscaner = new Scanner (System.in); 
        continente = entradaEscaner.nextLine ();
        System.out.println("Por favor introduzca otra oracion por teclado");
        String contenido = "";
        contenido = entradaEscaner.nextLine ();
        System.out.println("La frencuencia de la segunda oracion en la primera es la siguiente: " + Frecuencia(contenido,continente));        
    }
    public static int Frecuencia(String contenido, String continente){
        int posicionFrase = 0;
        int contadorDePalabras = 0;
        while(continente.length() != posicionFrase){
            int posicionPalabra = 0;
            for(;posicionPalabra<contenido.length();posicionPalabra++){
                if(continente.charAt(posicionFrase+posicionPalabra) != contenido.charAt(posicionPalabra)){
                    break;
                }
            }
            if(posicionPalabra == contenido.length()){
                contadorDePalabras++;
            }
            posicionFrase++;
        }
        return contadorDePalabras;
    }
}
