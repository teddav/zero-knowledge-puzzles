pragma circom 2.1.4;

// Input 3 values using 'a'(array of length 3) and check if they all are equal.
// Return using signal 'c'.

include "../node_modules/circomlib/circuits/comparators.circom";

template Equality() {
   signal input a[3];

   signal tmp1 <== IsZero()(a[0] - a[1]);
   signal tmp2 <== IsZero()(a[0] - a[2]);

   signal output c <== tmp1 * tmp2;
}

component main = Equality();