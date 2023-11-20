package compiler.lexical;

import compiler.syntax.sym;
import compiler.lexical.Token;
import es.uned.lsi.compiler.lexical.ScannerIF;
import es.uned.lsi.compiler.lexical.LexicalError;
import es.uned.lsi.compiler.lexical.LexicalErrorManager;

// incluir aqui, si es necesario otras importaciones

%%
 
%public
%class Scanner
%char
%line
%column
%cup
%unicode


%implements ScannerIF
%scanerror LexicalError

// incluir aqui, si es necesario otras directivas
%ignorecase
%full

%{
  LexicalErrorManager lexicalErrorManager = new LexicalErrorManager ();
  private int commentCount = 0;

  Token newToken(int i){
      Token tkn = new Token(i);
      tkn.setLine (yyline + 1);
      tkn.setColumn (yycolumn + 1);
      tkn.setLexema (yytext ());
      return tkn;
  }

%}  
  

ESPACIO_BLANCO=[ \t\r\n\f]
fin = "fin"{ESPACIO_BLANCO}
STRTEXT = \"[^\n\r]*\"
COMMENT = "--"[^\n\r]*{ESPACIO_BLANCO}
DIGIT  = [0-9]
LETTRE   = [a-zA-Z]
INTEGER  = {DIGIT}+
IDENTIFIER = {LETTRE}+({LETTRE}|{DIGIT})*


%%

<YYINITIAL> 
{
    // incluir aqui el resto de las reglas patron - accion
    //"+"                 {return newToken(sym.PLUS);}
    "-"                 {return newToken(sym.MINUS);}
    "*"                 {return newToken(sym.MULT);}
    ">"                 {return newToken(sym.GREATER);}
    "/="                {return newToken(sym.DISTINC);}
    ":="                {return newToken(sym.ASSIGN);}
    "."                 {return newToken(sym.ACCESS);}
    "("                 {return newToken(sym.LPAR);}
    ")"                 {return newToken(sym.RPAR);}
    ":"                 {return newToken(sym.COL);}
    ";"                 {return newToken(sym.SEMI);}
    ","                 {return newToken(sym.COMMA);}
    "and"               {return newToken(sym.AND);}
    "begin"             {return newToken(sym.BEGIN);}
    "Boolean"           {return newToken(sym.BOOL);}
    "constant"          {return newToken(sym.CONST);}
    "if"                {return newToken(sym.IF);}
    "else"              {return newToken(sym.ELSE);}
    "then"              {return newToken(sym.THEN);}
    "end"               {return newToken(sym.END);}
    "False"             {return newToken(sym.FALSE);}
    "True"              {return newToken(sym.TRUE);}
    "function"          {return newToken(sym.FUNCT);}
    "Integer"           {return newToken(sym.INT);}
    "loop"              {return newToken(sym.LOOP);}
    "while"             {return newToken(sym.WHILE);}
    "is"                {return newToken(sym.IS);}
    "out"               {return newToken(sym.OUT);}
    "Put_line"          {return newToken(sym.PUTLINE);}
    "record"            {return newToken(sym.RECORD);}
    "return"            {return newToken(sym.RETURN);}
    "type"              {return newToken(sym.TYPE);}
    "procedure"         {return newToken(sym.PROCEDURE);}
    {STRTEXT}           {return newToken(sym.STRTEXT);}
    {INTEGER}           {return newToken(sym.INTEGER);}
    {IDENTIFIER}        {return newToken(sym.IDENTIFIER);}
    {COMMENT}           {lexicalErrorManager.lexicalInfo("Non Token - [ Comentario de linea = "+(yytext())+" , line = "+(yyline+1)+", column = "+(yycolumn+1)+"]\n");}


   {ESPACIO_BLANCO}	{}

{fin} {}
    
    // error en caso de coincidir con ning�n patr�n
	[^]     
                        {                                               
                           LexicalError error = new LexicalError ();
                           error.setLine (yyline + 1);
                           error.setColumn (yycolumn + 1);
                           error.setLexema (yytext ());
                           //lexicalErrorManager.lexicalError (error);
                           lexicalErrorManager.lexicalError ("Token - [ Token no valido, line = "+(yyline+1)+", column = "+(yycolumn+1)+"]");
                        }
    
}


                         


