function X1 = new_marking(t,pn)
%			X1 = new_markings(t,pn)

A = pn.incidence_matrix;
X = pn.X;
Ps = size(A,2)/2;
Removals = A(t,1:Ps);
Deposits = A(t,Ps+1:2*Ps);
X1 = X + Deposits - Removals;

