pragma circom 2.1.4;

// Create a circuit which takes an input 'a',(array of length 2 ) , then  implement power modulo 
// and return it using output 'c'.

// HINT: Non Quadratic constraints are not allowed. 

include "../node_modules/circomlib/circuits/comparators.circom";

template Pow(max) {
   signal input a[2];

   signal pow[max];
   signal equal[max];
   signal result[max];

   pow[0] <== 1;
   equal[0] <== 0;
   result[0] <== 0;

   var i = 1;
   while (i < max) {
      equal[i] <== IsEqual()([i, a[1]]);        
      pow[i] <== pow[i - 1] * a[0];
      i++;
   }

   i = 1;
   while (i < max) {
      result[i] <== result[i - 1] + pow[i] * equal[i];
      i++;
   }

   signal output c <== result[i - 1];
}

component main = Pow(10);