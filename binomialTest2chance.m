function p = binomialTest2chance(c1,n1,chance,nsamps)
%p = biomialTest(c1,n1,c2,n2,[nsamps])
%
%Statistial test that compares two binomial samples using
%a Monte Carlo simulation.
%
%Inputs: c1,c2    number of correct responses for the two samples
%        n1,n2    total number of trials
%        nsamps   number samples in the simulation.  Default is 1000.
%
%Outputs:    p    p-value of the one-tailed test of whether c1/n1 > c2/n2.
%
%REQUIRES:  shuffle.m
%SEE ALSO:  DemoBinomialTest.m

%G.M. Boynton wrote it, summer 98

p1 = c1/n1;
p2 = chance;
c2=round(p2*n1);
n2=n1;
if ~exist('nsamps')
   nsamps = 1000;
end

%generate a column vector of length n1+n2 
%with c1+c2 ones,
%and the rest zeros.
r = zeros(n1+n2,1);
r(1:(c1+c2))=ones(c1+c2,1);

%duplicate this colunn vector nsamps times to make a matrix.
r = repmat(r,1,nsamps);

%randomly reorder each of the columns of r
r=shuffle(r);

%for each column, calculate the proportion of
%ones for each block (1:n1) and (n1+1:n1+n2)

p1Est = sum(r(1:n1,:))/n1 ;
p2Est = sum(r(n1+1:n1+n2,:))/n2;

%count the number of times p1Est-p2Est exceeds p1-p2.
%This is our p-value.  Note the hack:  average across
%> and >=.  This gives the expected value.
pgreater = sum( p1Est-p2Est > p1-p2)/nsamps;
pgreaterorequal = sum( p1Est-p2Est >= p1-p2)/nsamps;
p = mean([pgreater,pgreaterorequal]);

