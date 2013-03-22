A = sparse(a(:,1),a(:,3),a(:,2),200,200);
A = full(A);
A = A+A';
A(A>1)=1;
I=eye(200);
A=A-I;
A(A<0)=1;
csvwrite('../true',A);

