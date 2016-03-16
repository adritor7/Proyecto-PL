//
//  main.cpp
//  LexicalAnalizerForÑ
//
//  Created by Laura del Pino Díaz on 14/3/16.
//  Copyright © 2016 Laura del Pino Díaz. All rights reserved.
//

#include <iostream>
#include "global.h"
#include "Scanner.hpp"
#include "TokenChooser.hpp"

int main(int argc, const char * argv[]) {
    
    Scanner s = *new Scanner("test.ng");
    TokenChooser tc = *new TokenChooser();
    char c;
    
    //TODO modificar esto con la nueva función de tookenchoser hasnext
    for(;;){
        c = s.nextChar();
        tc.accept(c);
    }
    
    
    return 0;
}
