//
//  Scanner.cpp
//  LexicalAnalizerForÑ
//
//  Created by Laura del Pino Díaz on 16/3/16.
//  Copyright © 2016 Laura del Pino Díaz. All rights reserved.
//

#include "Scanner.hpp"

Scanner::Scanner(const char* path){

    this->file = fopen(path, "r");
}

char Scanner::nextChar(){
    this->current = fgetc(this->file);
    return this->current;
}

bool Scanner::hasNext(){
    return this->current == EOF;
}