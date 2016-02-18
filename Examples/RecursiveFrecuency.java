package recursive.frecuency;

import java.util.Scanner;

/**
 *
 * @author Laura
 */
public class RecursiveFrecuency {

    private static int recursive_frecuencia(String sub, String texto, int i_sub, int i_text) {
        
        if(i_text == texto.length()) return (i_sub == sub.length())? 1:0;
        if(i_sub == sub.length()) return 1+recursive_frecuencia(sub, texto, 0, i_text+1);
        if (sub.charAt(i_sub) != texto.charAt(i_text)) return recursive_frecuencia(sub, texto, 0, i_text+1);
        if (sub.charAt(i_sub) == texto.charAt(i_text)) return recursive_frecuencia(sub, texto, i_sub+1, i_text+1);
        return 0;
    }

    int frecuency = 0;
    
    public static void main(String[] args) {
        /* Indicamos la frencuencia de una cadena dentro de otra,teniendo
         en cuenta que pueden ser subcadenas de la cadena principal.
         */
        System.out.println("Por favor introduzca una oración por teclado:");
        String continente = "";
        Scanner entradaEscaner = new Scanner(System.in);
        continente = entradaEscaner.nextLine();
        System.out.println("Por favor introduzca otra oracion por teclado");
        String contenido = "";
        contenido = entradaEscaner.nextLine();
        System.out.println("La frencuencia de la segunda oracion en la primera es la siguiente: " + Frecuencia(contenido, continente));
    }
    
    public static int Frecuencia(String sub, String texto){
        return recursive_frecuencia(sub,texto, 0, 0);
    }

}
