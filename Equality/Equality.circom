pragma circom 2.1.4;

// Input 3 values using 'a'(array of length 3) and check if they all are equal.
// Return using signal 'c'.

include "../node_modules/circomlib/circuits/comparators.circom";

template MyIsZero() {
   signal input in;
   signal inverse <-- in == 0 ? 0 : 1/in;
   signal output out <== -in * inverse + 1;

   in * out === 0;
}

template Equality() {
   signal input a[3];

   signal tmp1 <== MyIsZero()(a[0] - a[1]);
   signal tmp2 <== MyIsZero()(a[0] - a[2]);

   signal output c <== tmp1 * tmp2;
}

component main = Equality();