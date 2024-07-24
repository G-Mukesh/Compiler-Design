%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void validate_dob(const char* dob) {
    int day, month, year;
    sscanf(dob, "%d-%d-%d", &day, &month, &year);

    // Basic validation for day, month, and year
    if (year < 1900 || year > 2023) {
        printf("Invalid DOB: %s (Year out of range)\n", dob);
    } else if (month < 1 || month > 12) {
        printf("Invalid DOB: %s (Month out of range)\n", dob);
    } else if (day < 1 || day > 31) {
        printf("Invalid DOB: %s (Day out of range)\n", dob);
    } else if ((month == 4 || month == 6 || month == 9 || month == 11) && day > 30) {
        printf("Invalid DOB: %s (Day out of range for month)\n", dob);
    } else if (month == 2) {
        // Check for leap year
        int is_leap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
        if ((is_leap && day > 29) || (!is_leap && day > 28)) {
            printf("Invalid DOB: %s (Day out of range for February)\n", dob);
        } else {
            printf("Valid DOB: %s\n", dob);
        }
    } else {
        printf("Valid DOB: %s\n", dob);
    }
}

void invalid_dob(const char* dob) {
    printf("Invalid format: %s\n", dob);
}
%}

%%

[0-3][0-9]-[0-1][0-9]-[0-9]{4} {
    validate_dob(yytext);
}

.|\n {
    invalid_dob(yytext);
}

%%

int main() {
    printf("Enter DOBs to check their validity (format: DD-MM-YYYY):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
