//
//  TokenChooser.hpp
//  LexicalAnalizerForÑ
//
//  Created by Laura del Pino Díaz on 16/3/16.
//  Copyright © 2016 Laura del Pino Díaz. All rights reserved.
//

#ifndef TokenChooser_hpp
#define TokenChooser_hpp
#include "Writer.hpp"
#endif /* TokenChooser_hpp */

class TokenChooser {
    Writer * w;
    void (*state_callback)(char);
public:
    TokenChooser();
    void accept(char c);
    
};