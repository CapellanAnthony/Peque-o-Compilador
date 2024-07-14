import compilerTools.Token;

%%
%class Lexer
%type Token
%line
%column
%{
    private Token token(String lexeme, String lexicalComp, int line, int column){
        return new Token(lexeme, lexicalComp, line+1, column+1);
    }
%}
/* Variables básicas de comentarios y espacios */
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
ComentarioTradicional = "/*" [^*] ~"*/" | "/*" "*"+ "/"
FinDeLineaComentario = "//" {EntradaDeCaracter}* {TerminadorDeLinea}?
ContenidoComentario = ( [^*] | \*+ [^/*] )*
ComentarioDeDocumentacion = "/**" {ContenidoComentario} "*"+ "/"

/* Comentario */
Comentario = {ComentarioTradicional} | {FinDeLineaComentario} | {ComentarioDeDocumentacion}

/* Identificador */
Letra = [A-Za-zÑñ_ÁÉÍÓÚáéíóúÜü]
Let = [A-Z][a-z]
Digito = [0-9]+
Identificador = {Letra}({Letra}|{Digito})*
/* Número */
Numero = 0 | [1-9][0-9]*
%%

/* Comentarios o espacios en blanco */
{Comentario}|{EspacioEnBlanco} { /*Ignorar*/ }


/*Números*/

{Numero} { return token(yytext(), "NUMERO", yyline, yycolumn); }



/*Operadores de agrupacion*/

"(" { return token(yytext(), "PARENTESIS_A", yyline, yycolumn); }
")" { return token(yytext(), "PARENTESIS_C", yyline, yycolumn); }
"{" { return token(yytext(), "LLAVE_A", yyline, yycolumn); }
"}" { return token(yytext(), "LLAVE_C", yyline, yycolumn); }


/*Signos de Puntuación*/

"," { return token(yytext(), "COMA", yyline, yycolumn); }
";" { return token(yytext(), "PUNTO_COMA", yyline, yycolumn); }
\" { return token(yytext(), "COMILLA_DOBLE", yyline, yycolumn); }
\' { return token(yytext(), "COMILLA_SIMPLE", yyline, yycolumn); }


/*Operadores Aritméticos*/

"+" { return token(yytext(), "OPE_SUMA", yyline, yycolumn); }
"-" { return token(yytext(), "OPE_RESTA", yyline, yycolumn); }
"++" { return token(yytext(), "OPE_INCREMENTO", yyline, yycolumn); }
"--" { return token(yytext(), "OPE_DECREMENTO", yyline, yycolumn); }
"*" { return token(yytext(), "OPE_MULT", yyline, yycolumn); }
\\ { return token(yytext(), "OPE_DIV", yyline, yycolumn); }
"%" { return token(yytext(), "OPE_MOD", yyline, yycolumn); }



/*Operadores Relacionales*/

"<" { return token(yytext(), "OPE_REL", yyline, yycolumn); }
">" { return token(yytext(), "OPE_REL", yyline, yycolumn); }
"=" { return token(yytext(), "OPE_ASIG", yyline, yycolumn); }
"==" { return token(yytext(), "OPE_IGUAL", yyline, yycolumn); }
"<=" { return token(yytext(), "OPE_REL", yyline, yycolumn); }
">=" { return token(yytext(), "OPE_REL", yyline, yycolumn); }
"!=" { return token(yytext(), "DIFERENTE", yyline, yycolumn); }


/*Operadores LÓGICOS*/

"&&" { return token(yytext(), "OPE_AND", yyline, yycolumn); }
"|| " { return token(yytext(), "OPE_OR", yyline, yycolumn); }
"!" { return token(yytext(), "NEGACION", yyline, yycolumn); }



/*Operadores DE ASIGNACIÓN*/

"*=" { return token(yytext(), "OPE_ASIG_PROD", yyline, yycolumn); }
"/=" { return token(yytext(), "OPE_ASIG_DIV", yyline, yycolumn); }
"+=" { return token(yytext(), "OPE_ASIG_SUM", yyline, yycolumn); }
"-=" { return token(yytext(), "OPE_ASIG_REST", yyline, yycolumn); }
"%=" { return token(yytext(), "OPE_ASIG_MOD", yyline, yycolumn); }
"<<=" { return token(yytext(), "DESPLZ_IZQ", yyline, yycolumn); }
"<<=" { return token(yytext(), "DESPLZ_DER", yyline, yycolumn); }
"&=" { return token(yytext(), "OPE_ASIG_AND", yyline, yycolumn); }
"^=" { return token(yytext(), "OPE_ASIG_XOR", yyline, yycolumn); }
"|=" { return token(yytext(), "OPE_ASIG_OR", yyline, yycolumn); }


/*Palabras Reservadas*/

auto | break | 
case | const | continue  | 
default | do | else |extern | 
for | goto | if | 
register | return | signed  | 
sizeof | static | typedef |union | 
unsigned | void | volatile |_Packed | 
printf | scanf | cout | cin | 
asm | dynamic_cast |  reinterpret_cast |
try | explicit | new |  
static_cast | typeid | catch |  operator | template |
typename | class | friend | 
private | this  | const_cast |
inline | public  | throw  | 
virtual   delete | mutable | 
protected | wchar_t | 
strcmp { return token(yytext(), "PAL_RESER", yyline, yycolumn); }

#include { return token(yytext(), "PAL_RES_INCL", yyline, yycolumn); }

/*Clase main */

main { return token(yytext(), "CLASS_PRINC", yyline, yycolumn); }
using { return token(yytext(), "PAL_RES_USING", yyline, yycolumn); }
namespace { return token(yytext(), "ESP_NOM", yyline, yycolumn); }
std { return token(yytext(), "PAL_RES_STD", yyline, yycolumn); }

/*Tipos de Datos*/

struct | 
enum |
int |
short|
long | 
float|
double| 
bool |
char| 
string|String { return token(yytext(), "TIPO_DATO", yyline, yycolumn); }


\"{Letra}+\"  { return token(yytext(), "CADENA", yyline, yycolumn); } 
{Numero} { return token(yytext(), "NUMERO", yyline, yycolumn); } 
{Numero}\.{Numero}|{Numero}\,{Numero} { return token(yytext(), "NUM_DEC", yyline, yycolumn); } 



"<conio.h>" | "<stdlib.h>"|
"<stdio.h>" |  "<string.h>" |
"<cstring.h>" | "<list>" |
"<iostream>" |
"<math.h>" { return token(yytext(), "LIBRERIA_C", yyline, yycolumn); }  


{Letra}  { return token(yytext(), "VARIABLE", yyline, yycolumn); } 

/*ERRORES*/
{Numero}|{Letra} { return token(yytext(), "Error1", yyline, yycolumn); } 



 
. { return token(yytext(), "Error", yyline, yycolumn); }
