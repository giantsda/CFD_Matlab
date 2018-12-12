x0=0;
[R2, F ]=fsolve(@denitrification,x0,[] );



[F, BOD_l1]= denitrification (R2)