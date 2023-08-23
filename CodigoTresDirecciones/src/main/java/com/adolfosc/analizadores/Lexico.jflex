

package com.adolfosc.analizadores;
import java_cup.runtime.*;
import com.adolfosc.analizadores.sym.*;
import java.util.List;
import java.util.ArrayList;
import com.adolfosc.analizadores.ErrorCom;

%%
//Configuracion JFLEX
%public
%class Lexico
%standalone
%line
%column
%cup

//Expresiones Regulares


/*--------------Literales---------------*/
letra               = [a-zA-Z]
digito              = [0-9]
numero              = {digito}+([.]{digito}{1,6})?


/*----------Espacios En blanco----------*/
espacio             = " "
saltoLinea          = \n|\r|\r\n
espacioblanco       = ({espacio}|{saltoLinea}| [\t\n])+

/*------------Identificador------------*/
identificador       = ({letra}|"_") ({letra}|{digito}|"_")*



/*--------- Codigo Incrustado ---------*/
%{
    private List<ErrorCom> erroresCom;
    private int identCant;
    private boolean identar;

    private void error(String lexeme) {
        erroresCom.add(new ErrorCom("Lexico","Simbolo no existe en el lenguaje",String.valueOf(yyline+1),String.valueOf(yycolumn+1),lexeme));
    }

    private void errorPrueba(String lexeme, String tipo) {
        erroresCom.add(new ErrorCom("PRUEBA",tipo,String.valueOf(yyline+1),String.valueOf(yycolumn+1),lexeme));
    }

    public List<ErrorCom> getErroresCom() {
        return erroresCom;
    }
%}

%init{
    erroresCom = new ArrayList<>();
%init}

%%


//Reglas Lexicas
<YYINITIAL> {

    {espacioblanco}         {/*vacio*/}

    {identificador}         {return new Symbol(sym.ID,yyline+1,yycolumn+1, yytext());}
    {numero}                {return new Symbol(sym.NUMERO,yyline+1,yycolumn+1, yytext());}
    /*------------ Operadores ------------*/
    "+"                     {return new Symbol(sym.SUMA,yyline+1,yycolumn+1, yytext());}
    "-"                     {return new Symbol(sym.RESTA,yyline+1,yycolumn+1, yytext());}
    "*"                     {return new Symbol(sym.MULT,yyline+1,yycolumn+1, yytext());}
    "/"                     {return new Symbol(sym.DIVI,yyline+1,yycolumn+1, yytext());}
    "("                     {return new Symbol(sym.PARI,yyline+1,yycolumn+1, yytext());}
    ")"                     {return new Symbol(sym.PARD,yyline+1,yycolumn+1, yytext());}
    ";"                     {return new Symbol(sym.PUNTCOMA,yyline+1,yycolumn+1, yytext());}
    "="                     {return new Symbol(sym.IGUAL,yyline+1,yycolumn+1, yytext());}




}

/* Error por cualquier otro simbolo*/
[^]
		{ error(yytext()); new Symbol(sym.error,yyline,yycolumn, yytext());}
