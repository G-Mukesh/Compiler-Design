%{
#include<stdio.h>
%}

%%
[A-Z]+ {printf("capital word: %s\n,yytext);}
.|\n 
%%
int main(int argc,char *argv[]){
yylex();
return 0;
}