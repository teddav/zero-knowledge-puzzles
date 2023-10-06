pragma circom 2.1.4;

// In this exercise , we will learn how to check the range of a private variable and prove that 
// it is within the range . 

// For example we can prove that a certain person's income is within the range
// Declare 3 input signals `a`, `lowerbound` and `upperbound`.
// If 'a' is within the range, output 1 , else output 0 using 'out'

include "../node_modules/circomlib/circuits/comparators.circom";

template Range() {
    signal input a, lowerbound, upperbound;
    signal lower <== LessThan(8)([lowerbound, a]);
    signal upper <== LessThan(8)([a, upperbound]);
    signal output out <== lower * upper;
}

component main  = Range();


