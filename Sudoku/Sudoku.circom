pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";

//include "../NotEqual/NotEqual.circom";
template NotEqual() {
    signal input a[2];
    signal tmp <== IsZero()(a[0] - a[1]);
    signal output c <== -1 * tmp + 1;
}

/*
    Given a 4x4 sudoku board with array signal input "question" and "solution", check if the solution is correct.

    "question" is a 16 length array. Example: [0,4,0,0,0,0,1,0,0,0,0,3,2,0,0,0] == [0, 4, 0, 0]
                                                                                   [0, 0, 1, 0]
                                                                                   [0, 0, 0, 3]
                                                                                   [2, 0, 0, 0]

    "solution" is a 16 length array. Example: [1,4,3,2,3,2,1,4,4,1,2,3,2,3,4,1] == [1, 4, 3, 2]
                                                                                   [3, 2, 1, 4]
                                                                                   [4, 1, 2, 3]
                                                                                   [2, 3, 4, 1]

    "out" is the signal output of the circuit. "out" is 1 if the solution is correct, otherwise 0.                                                                               
*/


template Sudoku () {
    // Question Setup 
    signal input  question[16];
    signal input solution[16];
    signal output out;
    
    // Checking if the question is valid
    for(var v = 0; v < 16; v++){
        log(solution[v],question[v]);
        assert(question[v] == solution[v] || question[v] == 0);
    }
    
    var m = 0 ;
    component row1[4];
    for(var q = 0; q < 4; q++){
        row1[m] = IsEqual();
        row1[m].in[0]  <== question[q];
        row1[m].in[1] <== 0;
        m++;
    }
    3 === row1[3].out + row1[2].out + row1[1].out + row1[0].out;

    m = 0;
    component row2[4];
    for(var q = 4; q < 8; q++){
        row2[m] = IsEqual();
        row2[m].in[0]  <== question[q];
        row2[m].in[1] <== 0;
        m++;
    }
    3 === row2[3].out + row2[2].out + row2[1].out + row2[0].out; 

    m = 0;
    component row3[4];
    for(var q = 8; q < 12; q++){
        row3[m] = IsEqual();
        row3[m].in[0]  <== question[q];
        row3[m].in[1] <== 0;
        m++;
    }
    3 === row3[3].out + row3[2].out + row3[1].out + row3[0].out; 

    m = 0;
    component row4[4];
    for(var q = 12; q < 16; q++){
        row4[m] = IsEqual();
        row4[m].in[0]  <== question[q];
        row4[m].in[1] <== 0;
        m++;
    }
    3 === row4[3].out + row4[2].out + row4[1].out + row4[0].out; 

    // Write your solution from here.. Good Luck!
    var LENGTH = 4;

    signal valid_rows[LENGTH];
    signal valid_cols[LENGTH];
    for (var i = 0; i < LENGTH; i++) {
        var array_index = i * LENGTH;
        var row[LENGTH] = [solution[array_index + 0], solution[array_index + 1], solution[array_index + 2], solution[array_index + 3]];
        var column[LENGTH] = [solution[i], solution[i + LENGTH], solution[i + LENGTH * 2], solution[i + LENGTH * 3]];
        valid_rows[i] <== UniqueDigits(LENGTH)(row);
        valid_cols[i] <== UniqueDigits(LENGTH)(column);
    }

    var valid_rows_and_cols = 0;
    for (var i = 0; i < LENGTH; i++) {
        valid_rows_and_cols += valid_rows[i];
        valid_rows_and_cols += valid_cols[i];
    }

    out <== IsEqual()([valid_rows_and_cols, 8]);
}

template UniqueDigits(LENGTH) {
    signal input in[LENGTH];
    signal unique[LENGTH][LENGTH];

    var total = 0;

    for (var i = 0; i < LENGTH; i++) {
        for (var j = 0; j < LENGTH; j++) {
            if (i != j) {
                unique[i][j] <== NotEqual()([in[i], in[j]]);
                total += unique[i][j];
            }
        }
    }
    var expected_total = LENGTH * LENGTH - LENGTH;
    signal output out <== IsEqual()([total, expected_total]);
}

component main = Sudoku();

