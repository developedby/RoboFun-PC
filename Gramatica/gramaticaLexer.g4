lexer grammar gramaticaLexer;

// Keywords

FUNCTION :	    'func';
BREAK :             'break';
CONTINUE :          'continue';
DO :                'do';
ELSE :              'else';
FOR :               'for';
IF :                'if';
RETURN :            'return';
WHILE :             'while';


// Types
VOID :              'void';
CHAR :              'char';
INT :               'int';
FLOAT :             'float';
UNSIGNED :          'unsigned';
VAR :               'var';
BOOL :		    'bool';
STRING :	    'string';
NUM :		    'num';

// Separators
LEFT_PARENTHESIS:   '(';
RIGHT_PARENTHESIS:  ')';
LEFT_BRACE:         '{';
RIGHT_BRACE:        '}';
LEFT_BRACKET:       '[';
RIGHT_BRACKET:      ']';
SEMICOLON:          ';';
COMMA:              ',';
DOT:                '.';


//Operators
INCREMENT :         '++';
DECREMENT :         '--';

GREATER_THAN :      '>';
LESSER_THAN :       '<';
GREATER_EQUAL :     '>=';
LESSER_EQUAL :      '<=';

LOGICAL_EQUAL :     '==';
LOGICAL_NOT_EQUAL : '!=';

ASSIGN :            '=';
MUL_ASSIGN :        '*=';
DIV_ASSIGN :        '/=';
MOD_ASSIGN :        '%=';
ADD_ASSIGN :        '+=';
SUB_ASSIGN :        '-=';
AND_ASSIGN :        '&=';
XOR_ASSIGN :        '^=';
OR_ASSIGN :         '|=';

PLUS:                '+';
MINUS:               '-';

LOGICAL_COMPLEMENT :'!';
BIT_COMPLEMENT :    '~';

MUL :               '*';
DIV :               '/';
MOD :               '%';

BIT_AND :           '&';
BIT_OR :            '|';
BIT_XOR :           '^';
LOGICAL_AND :       '&&';
LOGICAL_OR :        '||';

QUESTION:           '?';
COLON:              ':';

//Constants
CONSTANT
    :   IntegerConstant
    |   FloatingConstant
    |   CharacterConstant
    |   StringLiteral
    |   BooleanConstant
    ;

IDENTIFIER
    :   Letter (Letter | Digit)*;

//Fragments

fragment
Letter
    :   [a-zA-Z_$]
    ;
fragment
Digit
    :   [0-9]
    ;
fragment
BooleanConstant
    :   'true'
    |   'false'
    ;
fragment
IntegerConstant
    :   DecimalConstant
    |   HexadecimalConstant
    |   BinaryConstant
    ;
fragment
DecimalConstant
    :   ( '0' | [1-9] Digit* )
    ;
fragment
HexadecimalConstant
    :   '0' [xX] [0-9a-fA-F]+
    ;
fragment
BinaryConstant
   :   '0' [bB] [0-1]+
   ;
fragment
FloatingConstant
    :   FractionalConstant ExponentPart? 
    |   Digit+ ExponentPart
    ;
fragment
FractionalConstant
    :   Digit* '.' Digit+
    |   Digit+ '.'
    ;
fragment
ExponentPart
    :   [eE] [+-]? Digit+
    ;
fragment
CharacterConstant
    :   '\'' ConstChar+ '\''
    ;
fragment
ConstChar
    :   ~['\\\r\n]
    |   '\\' ['"?abfnrtv\\]
    ;
fragment
StringLiteral
    :   '"' StringChar* '"'
    ;
fragment
StringChar
    :   ~["\\\r\n]
    |   '\\' ['"?abfnrtv\\]
    |   '\\\n'
    |   '\\\r\n'
    ;


//Whitespace and comments

Whitespace
    :   [ \t]+ -> skip
    ;
Newline
    :   ('\r''\n'? | '\n') -> skip;
BlockComment
    :   '/*' .*? '*/' -> skip;
LineComment
    :   '//' ~[\r\n]* -> skip;
