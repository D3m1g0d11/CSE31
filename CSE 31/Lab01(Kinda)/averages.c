#include <stdio.h>
int main()
{
    	int input = -1;
    	double sumOdd = 0;
	double sumEven = 0;
	int counterOdd = 0;
	int counterEven = 0;

    while (input != 0)
    {
    printf("Please enter an integer: ");
        scanf("%d", &input);

        if(input == 0)
		{
			printf("\n");
			break;
		}

	else if (input % 2 == 0 || (input)*(-1) % 2 == 0)
		{
			sumEven += input;
			counterEven++;
		}
	else
		{
			sumOdd += input;
			counterOdd++;
		}
    }
	if(sumOdd == 0 && sumEven == 0)
		{
			printf("There is no averages.\n");
		}
	else
		{

			double aveEven = (sumEven/counterEven);
			double aveOdd = (sumOdd/counterOdd);

			if(sumEven != 0)
			{
			printf("Average of even numbers: %.2f\n", aveEven);
			}
			if(sumOdd != 0)
			printf("Average of odd numbers: %.2f\n", aveOdd);
		}

    return 0;
}