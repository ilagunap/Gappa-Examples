
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

## Set next v
v_right1 = rnd(alpha * d1);
v_right2 = rnd(alpha * d2);
v_new1 = rnd(v1 + v_right1);
v_new2 = rnd(v2 + v_right2);

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
d_new1 = rnd(r_new1 + d_right1);
d_new2 = rnd(r_new2 + d_right2);

### Updating new variables
#v_new1 = v_new1;
#v_new2 = v_new2;
#r_new1 = r_new1;
#r_new2 = r_new2;
#d_new1 = d_new1;
#d_new2 = d_new2;

############### Loop iteration 2 ###############
## Set q
q1_2 = rnd((A11 * d_new1) + rnd(A12 * d_new2));
q2_2 = rnd((A21 * d_new1) + rnd(A22 * d_new2));

## Set alpha
alpha_num_2 = rnd(rnd(r_new1 * r_new1) + rnd(r_new2 * r_new2));
alpha_den_2 = rnd(rnd(d_new1 * q1_2) + rnd(d_new2 * q2_2));
alpha_2 = rnd(alpha_num_2 / alpha_den_2);

## Set next v
v_right1_2 = rnd(alpha_2 * d_new1);
v_right2_2 = rnd(alpha_2 * d_new2);
v_new1_2 = rnd(v_new1 + v_right1_2);
v_new2_2 = rnd(v_new2 + v_right2_2);

## Set next r
r_right1_2 = rnd(alpha_2 * q1_2);
r_right2_2 = rnd(alpha_2 * q2_2);
r_new1_2 = rnd(r_new1 - r_right1_2);
r_new2_2 = rnd(r_new2 - r_right2_2);

## Residual norm (error)
error = sqrt(rnd(rnd(r_new1_2 * r_new1_2) + rnd(r_new2_2 * r_new2_2)));

############## Statements to proof #############
# Exact
#{b1 in [1,1] /\ b2 in [2,2] ->
#v_new1_2 in ? /\ v_new2_2 in ? /\ error in ?}

# Range on b input
{b1 in [0.90,1] /\ b2 in [1.90,2] /\
not alpha_num in [-1e-324,1e-324] /\
not alpha_den in [-1e-324,1e-324] /\
not alpha_num_2 in [-1e-324,1e-324] /\ 
not alpha_den_2 in [-1e-324,1e-324] -> 
d_new1 in ? /\ 
q1_2 in ? /\ 
d_new2 in ? /\ 
q2_2 in ? /\
alpha_2 in ? /\ alpha_num_2 in ? /\ alpha_den_2 in ? /\ v_new1_2 in ? /\ v_new2_2 in ? /\ error in ?}


############# Hints ###########################
