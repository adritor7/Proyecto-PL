//
//  TokenChooser.cpp
//  LexicalAnalizerForÑ
//
//  Created by Laura del Pino Díaz on 16/3/16.
//  Copyright © 2016 Laura del Pino Díaz. All rights reserved.
//

#include "TokenChooser.hpp"


TokenChooser::TokenChooser(){
    this->w = new Writer();
    this->regularExpressionInProcess = false;
}

void TokenChooser::accept(char c){
    this->queue.push_back(c);
    decide();
}

void TokenChooser::decide(){
    
    if(isCurrentWhiteSpace()){
        this->queue.pop_back();
        return;
    }
    
    
    if(!regularExpressionInProcess && isCurrentPartOfKeyword()){
        if(int token = completeKeyword() > 255){
            this->w->writeToken(token);
            this->queue.clear();
        }
        return;
    }
    
    if(isCurrentPartOfRegularExpression()){
        this->regularExpressionInProcess = true;
        //TODO return check key
    }
}

bool TokenChooser::isCurrentWhiteSpace(){
    return queue.back() == ' ';
}

bool TokenChooser::isCurrentPartOfKeyword(){

    if(this->queue.size() == 1) return checkFirstOrderKeyWords();
    else{
        std::string str_queue(this->queue.begin(), this->queue.end());
        return STRWORDSCONCAT.find(str_queue) != std::string::npos;
    }
}

bool TokenChooser::checkFirstOrderKeyWords(){
    char current = this->queue.front();
    switch (current) {
        case ',':
            this->w->writeToken(COMA);
            return true;
        case '=':
            this->w->writeToken(ASIGNACION);
            return true;
        case ';':
            this->w->writeToken(PUNTOYCOMA);
            return true;
        case ':':
            this->w->writeToken(DOSPUNTOS);
            return true;
        case '(':
            this->w->writeToken(ABREPARENTESIS);
            return true;
        case ')':
            this->w->writeToken(CIERRAPARENTESIS);
            return true;
        case '[':
            this->w->writeToken(ABRECORCHETES);
            return true;
        case ']':
            this->w->writeToken(CIERRACORCHETES);
            return true;
        case '{':
            this->w->writeToken(ABRELLAVES);
            return true;
        case '}':
            this->w->writeToken(CIERRALLAVES);
            return true;
        case '+':
            this->w->writeToken(SUMA);
            return true;
        case '-':
            this->w->writeToken(RESTA);
            return true;
        case '*':
            this->w->writeToken(MULTIPLICACION);
            return true;
        case '/':
            this->w->writeToken(DIVISION);
            return true;
        case '%':
            this->w->writeToken(MODULO);
            return true;
        case '>':
            this->w->writeToken(MAYOR_QUE);
            return true;
        case '<':
            this->w->writeToken(MENOR_QUE);
            return true;
        case '!':
            this->w->writeToken(NOT);
            return true;
        default:
            return false;
    }

}

int TokenChooser::completeKeyword(){
    std::string str_queue(this->queue.begin(), this->queue.end());
    size_t position = STRWORDSCONCAT.find(str_queue);
    
    switch (position) {
        case 0:
            return SI;
        case 2:
            return FIN;
        case 5:
            return CASO;
        case 9:
            return COMIENZAFUNCION;
        case 13:
            return NULO;
        case 17:
            return PARA;
        case 21:
            return SINO;
        case 25:
            return FINAL;
        case 30:
            return INICIO;
        case 36:
            return SALIDA;
        case 42:
            return SOLOSI;
        case 48:
            return RESERVAESPACIOVECTOR;
        case 55:
            return DEVUELVE;
        case 63:
            return MIENTRAS;
        case 71:
            return DEPENDE;
        case 80:
            return PORDEFECTO;
        case 90:
            return TIPOREAL;
        case 94:
            return TIPOVECTOR;
        case 100:
            return TIPOLETRA;
        case 107:
            return LEER;
        case 108:
            return ESCRIBIR;
            
        default:
            return -1;
    }
}