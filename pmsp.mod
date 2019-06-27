param V := 123456;
param num_mach;
param num_jobs;

/* sets */
set N := 1..num_jobs;
set N0 := 0..num_jobs;
set M := 1..num_mach;


/* Parametry */
param P{i in N,k in M};
param S{i in N,j in N,k in M};
param G{i in N, j in N, k in M} := S[i, j, k] + P[j, k];

/* Variables */
var X{i in N, j in N, k in M} >= 0 binary;
var C{j in N} >=0;
var Cmax >= 0;

minimize PMSP: Cmax;

s.t. UmaPredecessora{j in N}: sum{i in N, k in M: i != j} X[i, j, k] = 1;

s.t. Fluxo{h in N, k in M}: (sum{i in N0: i != h} X[i,h,k] - sum{j in N0: j != h} X[h, j, k]) = 0;

s.t. TempoProcesso{j in N, i in N0}: C[j] >= C[i] + sum{k in M} G[i,j,k] * X[i,j,k] + V*(sum{k in M} X[i, j , k] - 1);

s.t. Makespan{j in N: j > 0}: Cmax >= C[j];

s.t. Sucessor{k in M: k > 0}: sum{j in N} X[0, j, k] = 1;

end;
