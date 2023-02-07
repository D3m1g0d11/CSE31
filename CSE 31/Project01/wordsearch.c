#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
//Worked on it with Jovan Singh
// Declarations of the two functions you will implement
// Feel free to declare any helper functions or global variables
void printPuzzle(char** arr);
void searchPuzzle(char** arr, char* word);
void printIntPuzzle(int** arr);
int bSize;
bool found = false;
// Main function, DO NOT MODIFY (except line 52 if your output is not as expected -- see the comment there)!!!	
int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <puzzle file name>\n", argv[0]);
        return 2;
    }
    int i, j;
    FILE *fptr;

    // Open file for reading puzzle
    fptr = fopen(argv[1], "r");
    if (fptr == NULL) {
        printf("Cannot Open Puzzle File!\n");
        return 0;
    }

    // Read the size of the puzzle block
    fscanf(fptr, "%d\n", &bSize);
    
    // Allocate space for the puzzle block and the word to be searched
    char **block = (char**)malloc(bSize * sizeof(char*));
    char *word = (char*)malloc(20 * sizeof(char));

    // Read puzzle block into 2D arrays
    for(i = 0; i < bSize; i++) {
        *(block + i) = (char*)malloc(bSize * sizeof(char));
        for (j = 0; j < bSize - 1; ++j) {
            fscanf(fptr, "%c ", *(block + i) + j);            
        }
        fscanf(fptr, "%c \n", *(block + i) + j);
    }
    fclose(fptr);

    printf("Enter the word to search: ");
    scanf("%s", word);

    // Print out original puzzle grid

    printf("\nPrinting puzzle before search:\n");
    printPuzzle(block);

    // Call searchPuzzle to the word in the puzzle
    searchPuzzle(block, word);
    
    return 0;
}

void printPuzzle(char ** arr) {
	// This function will print out the complete puzzle grid (arr). It must produce the output in the SAME format as the samples in the instructions.
    // Your implementation here...
    for (int i = 0; i < bSize; i++)
    {
        for(int j = 0; j < bSize; j++)
        {
            printf("%c " , *(*(arr + i) + j));    
        }
        printf("\n");
    }
}

void recordIndex(int** arr, int i, int j, int val) {

    if(*(*(arr + i) + j) == 0)
    {
        *(*(arr + i) + j) = val;
    }
    
    else if(*(*(arr + i) + j) > 0)
    {
        *(*(arr + i) + j) = *(*(arr + i) + j) * 10 + val;    
    }
}

//Prints only interger 2D arrays
void printIntPuzzle(int** arr) {
    // This function will print out the complete puzzle grid (arr). It must produce the output in the SAME format as the samples in the instructions.
    // Your implementation here...
    for (int i = 0; i < bSize; i++)
    {
        for(int j = 0; j < bSize; j++)
        {
            printf("%d " , *(*(arr + i) + j));    
        }
        printf("\n");
    }  
}


bool adjacentCheck(char** arr, int i, int j, int index, char* word, int** finalArr)
{
    //recursive return
   // printf("size of word: %lu\n", strlen(word));
    if(index == strlen(word))
    {
        return true;
    }
    for(int k = i - 1; k <= i + 1; k++)
    {
        for(int l = j - 1; l <= j + 1; l++)
        {
            //Bounds
            if(k < 0 || l < 0 || k >= bSize || l >= bSize || (k == i && l == j))
            {
                continue;
            }
            //If it is the right character
            if(*(*(arr + k) + l) == *(word + index))
            {   
                index++;
                //Call recursive here and checks the next index
                if(adjacentCheck(arr, k, l, index, word, finalArr))
                {
                    recordIndex(finalArr, k, l, index);
                    return true; 
                }
                else
                {
                    index--;
                }
            }
        }
    }
    return false;
}

void upper(char *str1)                                          
{
    while(*str1!='\0')                                                   
        {
            if(*str1 > 96 && *str1 < 123)                          
                {
                *str1 = *str1-32;                                     
                }
            str1++;                                                        
        }
}

void searchPuzzle(char** arr, char* word) {
    // This function checks if arr contains the search word. If the word appears in arr, it will print out a message and the path as shown in 
    // the sample runs. If not found, it will print a different message as shown in the sample runs.
    // Your implementation here...

    upper(word);
    int index = 0;
    //if path is true there is at least 1 path available
    bool path = false;
    //Final is a local 2D array that maps out the pathways
    int **finalArr = (int**)malloc(bSize * sizeof(int*));

    for(int i = 0; i < bSize; i++)
    {
        *(finalArr + i) = (int*)malloc(bSize * sizeof(int));

        for(int j = 0; j < bSize; j++)
        {
            *(*(finalArr + i) + j) = 0;
        }
    }

    for(int i = 0; i < bSize; i++)
    {

        for(int j = 0; j < bSize; j++)
        {

            if(*(*(arr + i) + j) == *(word))
            { 
                index++;
                found = adjacentCheck(arr, i, j, index, word, finalArr);
                //Found is set to a bool
                if(found)
                {
                    //Records 1 in final Arr
                    recordIndex(finalArr, i, j, index);
                    path = found;
                }
                index = 0;
            }
        }

    }

    if(path)
    {
        printf("\nWord found!\n");
        printf("Printing the search path: \n");
        printIntPuzzle(finalArr);
    }
    else
    {
        printf("\nWord not found!\n");
    }

}
