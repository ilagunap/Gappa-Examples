
## Example

We run the `cg_bug.g` in gappa and get following bounds for `den`:

```sh
$ gappa cg_bug.g 
Warning: renaming identifier 'v2' as 'A12' at line 13 column 13
Warning: renaming identifier 'A12' as 'A21' at line 14 column 13
Warning: renaming identifier 'r1' as 'd1' at line 28 column 8
Warning: renaming identifier 'r2' as 'd2' at line 29 column 8
Warning: renaming identifier 'alpha_num' as 'beta_den' at line 49 column 44
Results:
  x1 in [-3429453839668883b-52 {-0.761492, -2^(-0.3931)}, 5341731000154621b-57 {0.0370657, 2^(-4.75377)}]
  x3 in [539519076657751b-50 {0.479189, 2^(-1.06133)}, 2122967819475829b-51 {0.942787, 2^(-0.084996)}]
  x2 in [-722483690752783b-48 {-2.56678, -2^(1.35996)}, 2456826006985493b-51 {1.09105, 2^(0.125716)}]
  x4 in [6089550160448257b-53 {0.676076, 2^(-0.564743)}, 806546000663113b-48 {2.86543, 2^(1.51875)}]
  den in [1b-114 {4.81482e-35, 2^(-114)}, 5242266066591587b-50 {4.65607, 2^(2.21911)}]
```
The inputs for `den` are `x1`,..., `x4`, and it is computed as `den = rnd(rnd(x1 * x2) + rnd(x3 * x4));`. 
In this case the range is `[1b-114, 5242266066591587b-50]`, which is large.

We take the inputs of `den` and place them in a separate file, `test.g` and compute `den`:

```sh
$ cat test.g 
@rnd = float< ieee_64, ne >;

x1 = rnd(a_);
x2 = rnd(b_);
x3 = rnd(c_);
x4 = rnd(d_);
den = rnd(rnd(x1 * x2) + rnd(x3 * x4));

{x1 in [-3429453839668883b-52,5341731000154621b-57] /\ 
x2 in [-722483690752783b-48,2456826006985493b-51] /\
x3 in [539519076657751b-50,2122967819475829b-51] /\
x4 in [3044775080224129b-52,6452368005304903b-51] /\
not den in [-1e-324,1e-324] -> 
x1 in ? /\ x2 in ? /\ x3 in ? /\ x4 in ? /\
den in ?}

$ gappa test.g 
Results:
  x1 in [-3429453839668883b-52 {-0.761492, -2^(-0.3931)}, 5341731000154621b-57 {0.0370657, 2^(-4.75377)}]
  x2 in [-722483690752783b-48 {-2.56678, -2^(1.35996)}, 2456826006985493b-51 {1.09105, 2^(0.125716)}]
  x3 in [539519076657751b-50 {0.479189, 2^(-1.06133)}, 2122967819475829b-51 {0.942787, 2^(-0.084996)}]
  x4 in [3044775080224129b-52 {0.676076, 2^(-0.564743)}, 6452368005304903b-51 {2.86543, 2^(1.51875)}]
  den in [-2282682000411225b-52 {-0.506857, -2^(-0.98035)}, 2621133033295793b-49 {4.65607, 2^(2.21911)}]
```

Now we get a different range for `den`:  `[-2282682000411225b-52, 2621133033295793b-49]`.
