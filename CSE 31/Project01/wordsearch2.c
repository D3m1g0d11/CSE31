#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Declarations of the two functions you will implement
// Feel free to declare any helper functions or global variables
void printPuzzle(char** arr);
void searchPuzzle(char** arr, char* word);
int bSize;

// Main function, DO NOT MODIFY
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
    // printPuzzle(block);
    
    // Call searchPuzzle to the word in the puzzle
    searchPuzzle(block, word);
    
    return 0;
}

void printPuzzle(char** arr) {
    // This function will print out the complete puzzle grid (arr). It must produce the output in the SAME format as the samples in the instructions.
    // Your implementation here...
    for(int col = 0; col < bSize; ++col)
    {
        for(int row = 0; row < bSize; ++row)
            printf("%c ", *(*(arr + col) + row));
        printf("\n");
    }
}

void printSolution(int** arr) {
    // This function will print out the complete puzzle grid (arr). It must produce the output in the SAME format as the samples in the instructions.
    // Your implementation here...
    for(int col = 0; col < bSize; ++col)
    {
        for(int row = 0; row < bSize; ++row)
            printf("%d\t", *(*(arr + col) + row));
        printf("\n");
    }
}

int findNext(char** arr, int** solution, char* word, int count, int col, int row)
{
    char checked_pos, letter;
    letter = *(word + count);
    
    if(count < strlen(word))
    {
        for(int i = -1; i < 2; i++)
        {
            for(int j = - 1; j < 2; j++)
            {
                if(col + i >= 0 && col + i < bSize && row + j >= 0 && row + j < bSize && !(i == 0 && j == 0))
                {
                    checked_pos = *(*(arr + col + i) + row + j);
                    
                    if( checked_pos == letter || checked_pos + 32 == letter )
                    {
                        if(count == strlen(word) - 1)
                        {
                            *(*(solution + col + i) + row + j) = count + 1;
                            return count;
                        }
                        if(findNext(arr, solution, word, count + 1, col + i , row + j) > 0)
                        {
                            
                            int* tmp = (*(solution + col + i) + row + j);
                            if(*tmp > 0)
                                *tmp *= 10;
                            *tmp += count + 1;
                            return count;
                        }
                    }
                }
            }
        }
    }
    return 0;
}

void findFirst(char** arr, int** solution, char* word)
{
    for(int i = 0; i < bSize; i++)
    {
        for(int j = 0; j < bSize; j++)
        {
            if(*(*(arr + i) + j) == *word || (*(*(arr + i) + j) + 32) == *word)
                // printf("%c ", *(*(arr + i) + j));
                if(findNext(arr, solution, word, 1, i, j) > 0)
                {
                    int* tmp = *(solution + i) + j;
                    if(*tmp > 0)
                        *tmp *= 10;
                    *tmp += 1;
                }
            
        }
    }
}


void searchPuzzle(char** arr, char* word) {
    // This function checks if arr contains the search word. If the word appears in arr, it will print out a message and the path as shown in
    // the sample runs. If not found, it will print a different message as shown in the sample runs.
    // Your implementation here...
    
    // Allocate space for 2d array that will hold the solution
    int **solution = (int**)malloc(bSize * sizeof(int*));
    for(int i = 0; i < bSize; i++)
    {
        *(solution + i) = (int*)malloc(bSize * sizeof(int));
        for(int j = 0; j < bSize; j++)
            (*(*(solution + i) + j)) = 0;
    }
    
    printPuzzle(arr);
    printf("\n");
    findFirst(arr, solution, word);
    int sum = 0;
    for(int i = 0; i < bSize; i++)
        for(int j = 0; j < bSize; j++)
            sum += (*(*(solution + i) + j));
    if(sum > 0)
    {
        printf("Word found!\nPrinting the search result:\n");
        printSolution(solution);
    }
    else
        printf("Word not found!\n");
}
