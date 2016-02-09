/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parse.to.pkgdouble;


/**
 *
 * @author lala
 */
public class ParseToDouble {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {

    
        String case1  = "1" +'\0';
        String case2  = "1030" + '\0';
        String case3  = "-32" + '\0';
        String case4  = "2.1" + '\0';
        String case5  = "-33.5" + '\0';
        
        double d;
        d = pl_parseDouble(case1);
        d =pl_parseDouble(case2);
        d =pl_parseDouble(case3);
        d =pl_parseDouble(case4);
        d =pl_parseDouble(case5);
        
    }

    private static double pl_parseDouble(String case1) {
        
        int posicion_coma = encuentra_posicion_coma( case1);
        int signo_negativo = es_negativo(case1);
        int parte_parte_entera = 0;
        double parte_decimal = 0;
        int index = 0;
        int result = 0, aux = 1, aux2 = 0;
        index = signo_negativo;
        
        while(case1.charAt(index) != '\0'){
            if(index < posicion_coma){
                if(index > 0) result *= 10;
                result += dameValor(case1.charAt(index));
                
            }else if(index > posicion_coma){
                aux = dame_potencia_de_diez(index - (posicion_coma+1));
                aux2 += dameValor(case1.charAt(index)) * aux;
            }
            index += 1;
        }
        parte_parte_entera = result;
        parte_decimal =  (aux2 / (double) dame_potencia_de_diez(index-(posicion_coma+1)));
        
return (signo_negativo == 0)? (double) (parte_parte_entera + parte_decimal): -(double) (parte_parte_entera + parte_decimal);
    }

    private static int encuentra_posicion_coma(String case1) {
        int index = 0;
        while(case1.charAt(index) != '\0')
        {
            if(case1.charAt(index) == '.') return index;
            index = index + 1;
        }
        return Integer.MAX_VALUE;
    }

    private static int es_negativo(String case1) {
        return case1.charAt(0) == '-'? 1 : 0;
    }

    private static int dame_potencia_de_diez( int i) {
        int returnable = 1;
        
        for (int j = 0; j < i ; j++) {
            returnable *=10;
        }
        
        return  returnable;
    }

    private static int dameValor(char charAt) {
        switch(charAt){
            case '1': return 1;
            case '2': return 2;
            case '3': return 3;
            case '4': return 4;
            case '5': return 5;
            case '6': return 6;
            case '7': return 7;
            case '8': return 8;
            case '9': return 9;
            case '0': return 0;
        }
        return -1;
    }
    
}
