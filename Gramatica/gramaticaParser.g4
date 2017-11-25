parser grammar gramaticaParser;

options { tokenVocab=gramaticaLexer; }


// Expressions
primaryExpression
    :   IDENTIFIER
    |   CONSTANT
    |   '(' expression ')'
    ;

postfixExpression
    :   primaryExpression
    |   postfixExpression '[' expression ']'
    |   postfixExpression '(' argumentExpressionList? ')'
    |   postfixExpression incrementalOperator
    |   '(' typeName ')' '{' initializerList '}'
    |   '(' typeName ')' '{' initializerList ',' '}'
    ;

argumentExpressionList
    :   assignmentExpression
    |   argumentExpressionList ',' assignmentExpression
    ;

unaryExpression
    :   postfixExpression
    |   incrementalOperator unaryExpression
    |   unaryOperator castExpression
    ;

castExpression
    :   unaryExpression
    |   '(' typeName ')' castExpression
    ;

multiplicativeExpression
    :   castExpression
    |   multiplicativeExpression multiplicativeOperator castExpression
    ;

additiveExpression
    :   multiplicativeExpression
    |   additiveExpression additiveOperator multiplicativeExpression
    ;

relationalExpression
    :   additiveExpression
    |   relationalExpression relationalOperator additiveExpression
    ;

equalityExpression
    :   relationalExpression
    |   equalityExpression equalityOperator relationalExpression
    ;

andExpression
    :   equalityExpression
    |   andExpression BIT_AND equalityExpression
    ;

exclusiveOrExpression
    :   andExpression
    |   exclusiveOrExpression BIT_XOR andExpression
    ;

inclusiveOrExpression
    :   exclusiveOrExpression
    |   inclusiveOrExpression BIT_OR exclusiveOrExpression
    ;

logicalAndExpression
    :   inclusiveOrExpression
    |   logicalAndExpression LOGICAL_AND inclusiveOrExpression
    ;

logicalOrExpression
    :   logicalAndExpression
    |   logicalOrExpression LOGICAL_OR logicalAndExpression
    ;

conditionalExpression
    :   logicalOrExpression
    |   logicalOrExpression '?' expression ':' conditionalExpression
    ;

assignmentExpression
    :   conditionalExpression
    |   unaryExpression assignmentOperator assignmentExpression
    ;

expression
    :   assignmentExpression
    |   expression ',' assignmentExpression
    ;

constantExpression
    :   conditionalExpression
    ;


// Operations
typeName
    :   VOID 
    |   CHAR 
    |   INT 
    |   FLOAT 
    |   UNSIGNED 
    |   VAR
    ;

incrementalOperator
    :   INCREMENT 
    |   DECREMENT
    ;

relationalOperator
    :   GREATER_THAN 
    |   LESSER_THAN 
    |   GREATER_EQUAL 
    |   LESSER_EQUAL
    ;
equalityOperator
    :   LOGICAL_EQUAL 
    |   LOGICAL_NOT_EQUAL
    ;

assignmentOperator
    :   ASSIGN 
    |   MUL_ASSIGN 
    |   DIV_ASSIGN 
    |   MOD_ASSIGN 
    |   ADD_ASSIGN
    |   SUB_ASSIGN
    |   AND_ASSIGN
    |   XOR_ASSIGN
    |   OR_ASSIGN
    ;
    
additiveOperator
    :   PLUS | MINUS
    ;

unaryOperator
    :   PLUS
    |   MINUS
    |   BIT_COMPLEMENT
    |   LOGICAL_COMPLEMENT
    ;

multiplicativeOperator
   :   MUL
   |   DIV
   |   MOD
   ;



//Declarations
compilationUnit
    :   translationUnit? EOF
    ;

translationUnit
    :   externalDeclaration
    |   translationUnit externalDeclaration
    ;

externalDeclaration
    :   functionDefinition
    |   declaration
    |   ';'
    ;

functionDefinition
    :  typeName? IDENTIFIER '(' parameterList? ')' compoundStatement
    ;

declaration
    :   typeName initDeclaratorList ';'
    ;

initDeclaratorList
    :   initDeclarator
    |   initDeclaratorList ',' initDeclarator
    ;

initDeclarator
    :   declarator ('=' initializer)?
    ;

declarator
    :   IDENTIFIER
    |   '(' declarator ')'
    |   declarator '[' assignmentExpression? ']'
    |   declarator '(' parameterList? ')'
    |   declarator '(' identifierList? ')'
    ;

parameterList
    :   parameterDeclaration.
    |   parameterList ',' parameterDeclaration
    ;

parameterDeclaration
    :   typeName declarator
    ;

identifierList
    :   IDENTIFIER
    |   identifierList ',' IDENTIFIER
    ;

initializer
    :   assignmentExpression
    |   '{' initializerList (',')? '}'
    ;

initializerList
    :   designation? initializer
    |   initializerList ',' designation? initializer
    ;

designation
    :   designator ASSIGN
    ;

designator
    :   '[' constantExpression ']'
    |   designator '[' constantExpression ']'
    ;


// Statements
statement
    :   compoundStatement
    |   expressionStatement
    |   selectionStatement
    |   iterationStatement
    |   jumpStatement
    ;

compoundStatement
    :   '{' blockItem* '}'
    ;

blockItem
    :   declaration
    |   statement
    ;

expressionStatement
    :   expression? ';'
    ;

selectionStatement
    :   IF '(' expression ')' statement ('else' statement)?
    ;

iterationStatement
    :   WHILE '(' expression ')' statement
    |   DO statement WHILE '(' expression ')' ';'
    |   FOR '(' forCondition ')' statement
    ;

forCondition
    :   declaration forExpression? ';' forExpression?
    |   expressionStatement forExpression? ';' forExpression?
    ;

forExpression
    :   assignmentExpression
    |   forExpression ',' assignmentExpression
    ;

jumpStatement
    :   CONTINUE ';'
    |   BREAK ';'
    |   RETURN expression? ';'
    ;





