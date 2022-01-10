#include <stdio.h>
#include <stdlib.h>
#define MAX_LINE 100001

int expression(char *p, int *i);
int term(char *p, int *i);
int factor(char *p, int *i);

char *p;

char peek()
{
    return *p;
}

char get()
{
    return *p++;
}

int number2()
{
    int result = get() - '0';
    while (peek() >= '0' && peek() <= '9')
    {
        result = 10*result + get() - '0';
    }
    return result;
}

int expression2();

int factor2() {

    if (peek() >= '0' && peek() <= '9')
        return number2();
    else if (peek() == '(')
    {
        get(); // '('
        int result = expression2();
        get(); // ')'
        return result;
    }
    else if (peek() == '-')
    {
        get();
        return -factor2();
    }
    return 0; // error
}

int term2() {
    int result = factor2();
    while (peek() == '*' || peek() == '/')
        if (get() == '*')
            result *= factor2();
        else
            result /= factor2();
    return result;
}

int expression2() {

    int result = term2();
    while (peek() == '+' || peek() == '-')
        if (get() == '+')
            result += term2();
        else
            result -= term2();
    return result;
    
}




int main()
{
    char s[MAX_LINE];
    int i = 0;  
    scanf("%s", s);
    p = s;
    printf("%d\n", expression(p, &i));
    return 0;
}
