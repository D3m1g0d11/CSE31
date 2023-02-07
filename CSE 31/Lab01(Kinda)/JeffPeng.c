#include <stdio.h> 
#include <string.h>
#include <stdbool.h>

int main()
{  
    int count = 1;
    char buffer[50];
    int input = 0;
    double totalEven = 0;
    double evenCount = 0;
    double totalOdd = 0;
    double oddCount = 0;
    bool check = true;

    while(check){
        if(count > 3 && count < 21){
            sprintf(buffer, "%d%s", count, "th");
            printf("Enter the %s number: ", buffer);
        }
        else if(count%10==1){
            sprintf(buffer, "%d%s", count, "st");

            printf("Enter the %s number: ", buffer);

        }
        else if(count%10==2){
            sprintf(buffer, "%d%s", count, "nd");
            printf("Enter the %s number: ", buffer);
           
        }
        else if(count%10==3){
            sprintf(buffer, "%d%s", count, "rd");
            printf("Enter the %s number: ", buffer);
        else{
            sprintf(buffer, "%d%s", count, "th");
            printf("Enter the %s number: ", buffer);
        }
        scanf("%d", &input);
        if(input == 0){
            check = false;
            printf("\n");
        }
        else{
        int tempInput = input;
        int tempTotal = 0;
        while(tempInput>0 || tempInput<0){
            if(tempInput<0){
                tempInput*=-1;
            }
            tempTotal+=tempInput%10;
            tempInput/=10;
        }
        if(tempTotal%2==0){
            if(tempTotal<0){
                totalEven-=input;
            }
            totalEven+=input;
            evenCount++;
        }
        else{
            if(tempTotal<0){
                totalEven-=input;
            }
            totalOdd+=input;
            oddCount++;
        }        
        count++;
        }
    }
    double avgEven = totalEven/evenCount;
    double avgOdd = totalOdd/oddCount;
    if(evenCount>0){
        printf("Average of inputs whose digits sum up to an even number: %.2f\n", avgEven);
    }
    if(oddCount>0){
        printf("Average of inputs whose digits sum up to an odd number: %.2f\n", avgOdd);
    }
    if(oddCount==0 && evenCount==0){
        printf("There is no average to compute.\n");
    }
    return 0;
} 