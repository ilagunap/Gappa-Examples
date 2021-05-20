
############## Initializations ###############
## Rounding mode
# @rnd_32 = float< ieee_32, ne >;
@rnd = float< ieee_64, ne >;

## Initial v vector
v1 rnd= 2.0;
v2 rnd= 1.0;

## A matrix
A11 rnd= 4.0;
A12 rnd= 1.0;
A21 rnd= 1.0;
A22 rnd= 3.0;

## b vector
#b1 rnd= 1.0;
#b2 rnd= 2.0;

## Initialization of r
tmp1 = rnd((A11 * v1) + rnd(A12 * v2));
tmp2 = rnd((A21 * v1) + rnd(A22 * v2));
r1 = rnd(b1 - tmp1);
r2 = rnd(b2 - tmp2);

## Initialization of d
d1 = r1;
d2 = r2;

############### Loop iteration 1 ###############
## Set q
q1 = rnd((A11 * d1) + rnd(A12 * d2));
q2 = rnd((A21 * d1) + rnd(A22 * d2));

## Set alpha
alpha_num = rnd(rnd(r1 * r1) + rnd(r2 * r2));
alpha_den = rnd(rnd(d1 * q1) + rnd(d2 * q2));
alpha = rnd(alpha_num / alpha_den);

## Set next r
r_right1 = rnd(alpha * q1);
r_right2 = rnd(alpha * q2);
r_new1 = rnd(r1 - r_right1);
r_new2 = rnd(r2 - r_right2);

## Set beta
beta_num = rnd(rnd(r_new1 * r_new1) + rnd(r_new2 * r_new2));
beta_den = rnd(rnd(r1 * r1) + rnd(r2 * r2));
beta = rnd(beta_num / beta_den);

## Set new d
d_right1 = rnd(beta * d1);
d_right2 = rnd(beta * d2);
x1 = rnd(r_new1 + d_right1);
x3 = rnd(r_new2 + d_right2);

############### Loop iteration 2 ###############
x2 = rnd((A11 * x1) + rnd(A12 * x3));
x4 = rnd((A21 * x1) + rnd(A22 * x3));

den = rnd(rnd(x1 * x2) + rnd(x3 * x4));

############## Statements to proof #############
{b1 in [0.90,1] /\ b2 in [1.90,2] /\
not den in [-1e-324,1e-324] -> 
x1 in ? /\ 
x2 in ? /\ 
x3 in ? /\ 
x4 in ? /\
den in ?}

############# Hints ###########################
