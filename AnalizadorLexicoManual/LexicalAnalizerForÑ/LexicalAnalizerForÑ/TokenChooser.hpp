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
#include "tokenDef.h"
#include "keywords.h"
#include <deque>
#include <string>
#endif /* TokenChooser_hpp */

class TokenChooser {
    Writer * w;
    std::deque<char> queue;
    bool regularExpressionInProcess;
    
private:
    void decide();
    bool isCurrentWhiteSpace();
    bool isCurrentPartOfKeyword();
    bool checkFirstOrderKeyWords();
    int completeKeyword();
    
public:
    TokenChooser();
    void accept(char c);
    
};