//
//  ASTNodes.hpp
//  ASTNodes
//
//  Created by Laura del Pino Díaz on 10/4/16.
//  Copyright © 2016 Laura del Pino Díaz. All rights reserved.
//
#pragma once
#include <string>
#include <vector>

class Node{};

template <class Data_node> class Value_node: Node{
    
protected:
    Data_node data;
    
public:
    Value_node(Data_node in_data){
        this->data = in_data;
    };
};


template <class Data_node> class Variable_node : Node{
protected:
    std::string identifier;
    Value_node<Data_node> value;
    bool declaration;
    
public:
    Variable_node(std::string id, Value_node<Data_node> value){
        this->identifier = id;
        this->value = value;
        this->declaration = false;
    };
    Variable_node(std::string id){
        this->identifier = id;
        this->declaration = true;
    };
    
    bool isDeclaration(){return this->declaration;};
};

class Main_node{
protected:
    std::vector<Node*> hijos;
    
public:
    Main_node(){
        this->hijos = *new std::vector<Node*>;
    };
    
    void nuevoHijo(Node* hijo){
        hijos.push_back(hijo);
    }
    
};


class FunctionCall_node:Node{
protected:
    std::string identifier;
    std::vector<Node*> params;
public:
    FunctionCall_node(std::string id){
        this->identifier = id;
        this->params = *new std::vector<Node*>;
    }
    
    void addParam(Node* param){
        this->params.push_back(param);
    }
    
};


class Expression:Node{
protected:
    int kind;
    Node* right;
    Node* left;
public:
    Expression(int k, Node* r, Node* l){
        this->kind = k;
        this->right = r;
        this->left = l;
    };
};