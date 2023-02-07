#include <stdio.h>
int main()
{
    int count, error;

    printf("Enter the number of repeition for the punishment phrase: ");
    scanf("%d", &count);

    while(count <= 0)
     {
	printf("Enter the number of repetitions for the punishment phrase again: ");
	scanf("%d", &count);
     }
     	printf("Enter the repeition count when you wish to introduce a typo: ");
	scanf("%d", &error);
    while(error <= 0 || error > count)
     {
         printf("You entered an invalid value for the typo placement! \n");
         printf("Enter the repetition count when you wish to introduce a typo again: ");
	//scanf("%d", &error);
     }

     for(int i = 0 ; i < count; i++)
     {
         if (i == error -1)
         {
             printf("C progranming languoge is the bezt! \n");
         }
         else
         {
             printf("C programming language is the best! \n");
         }

     }
    return 0;
}
