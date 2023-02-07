#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>



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
    printPuzzle(block);
    
    // Call searchPuzzle to the word in the puzzle
    searchPuzzle(block, word);
    
    return 0;
}

void printPuzzle(char** arr) {
	// This function will print out the complete puzzle grid (arr). It must produce the output in the SAME format as the samples in the instructions.
    // Your implementation here...
    for(int i = 0; i < bSize; i++){
		for(int j = 0; j < bSize; j++){
				printf("%c\t", *(*(arr + i) + j));
		}
		printf("\n");
	}
	printf("\n");
}
void upperCaser (char *word){
char* change = word;
while(*change) {
     if('a' <= *change || *change >= 'z') *change -= 32;
     change++;
}   
}

bool valid (int row, int col){
        return (row >= 0) && (row < bSize) && (col >= 0) && (col <bSize); //just checks if the letter is in the correct range

}

int searchThingy(char** arr, char* word, int row, int col, int index, int length, int **sol){
    int x[] = { -1, -1, -1,  0, 0,  1, 1, 1};//this and the y check all 8 directions
    int y[] = { -1,  0,  1, -1, 1, -1, 0, 1};
    int j = 0;
    if (index > (length) || *(*(arr + row) + col) != *(word + index)){ //if this stuff out of bounds or doesnt equal
       return 0;
    }
       // printf("index = %d, length = %d\n", index, length);
    
    	if (index == length){
        //printf("Found the %dth letter, %c, at (%d, %d).\n", index + 1, *(word + index), row, col);
        sol[row][col] = sol[row][col] * 10 + index + 1; // this prints the 5th value since it checks the first one
       // printf("Actually found everything!\n");
        return 1;
	}

    
     for(int dir = 0; dir < 8; dir ++)   {
                        // if(index == length){
                       //printf("I DID IT\n");
                       //token = 1;
                      // return 1;
                      // break;
                  // }
                       if (valid(row + *(x + dir), col + y[dir])){
                          // printf("going here; index = %d\n", index); 
                          if(searchThingy(arr, word, row + x[dir], col + y[dir], index + 1, length, sol)){
                            //printf("Found the %dth letter, %c, at (%d, %d).\n", index + 1, *(word + index), row, col);
                            sol[row][col] = sol[row][col] * 10 + index + 1;
                            return 1;
                           }
                   
                       }
                }
    return 0;
}


void searchPuzzle(char** arr, char* word) {
    // This function checks if arr contains the search word. If the word appears in arr, it will print out a message and the path as shown in 
    // the sample runs. If not found, it will print a different message as shown in the sample runs.
    // Your implementation here...
    int **sol = (int **) malloc(bSize * sizeof(int *));
    for(int i = 0; i<bSize; i++){
        *(sol + i) = (int *) malloc(bSize * sizeof(int));
        for(int j = 0; j < bSize; j++){
           *(*(sol +i) + j) = 0;
        }
    }

    int x[] = { -1, -1, -1,  0, 0,  1, 1, 1};
    int y[] = { -1,  0,  1, -1, 1, -1, 0, 1};
    int length = (strlen(word) - 1);
    int token = 0;
    int i = 0;
    int k= 0;
    int check = 0;
    int counter;

       for(int c = 0; c < length; c++){
    upperCaser(word);
       }

    //printf("Size of word = %d", strlen(word));
    for (counter = 0; counter < strlen(word); counter++){
        counter += counter;
    }
    for(int row = 0; row < bSize; row++){
        for(int col = 0; col < bSize; col++){
            //printf("%c\t", *(*(arr + row) + col));
            if (*(*(arr + row) + col) == *(word)) {
                //printf("FOUND IT\n");
                //printf("(%d,%d)", row, col);
                check = searchThingy(arr,word, row, col, 0, length, sol);

                
                if(check == 1) {
                    printf("Word found! \n");
                    printf("Printing the search path:\n");
                    
                    for (int p = 0; p < bSize; p++){
                        for(int q = 0; q <bSize; q++){
                            printf("%d\t", *(*(sol + p) + q));
                        }
                        printf("\n");
                    }
                //printf("THIS STUFF WORKS\n");
                return;
                
                }
               
            }

            
        }
    }
                                   
        printf("Word not found! \n");

                
} 
        
