function result=rk4(func,t,x,p,timeStep)
% computes a single time step using the Runge-Kutta order-4 Method.
% Input:
%	func = a function representing the rate of change that is 
%		evaluated as f(t,x,p) (these variables are explain below)
%	t=the current time
%	x=the current state or point along the trajectory
%	p= any structure containg parameters necessary to evaluate func 
%	timeStep = the size of the time step to take
%
% Output:
%	returns a matrix with the same dimensions as x represe-
%	nting the state of the next point along the trajectory after
%	a time step of size timeStep

s1=feval(func,t,x,p);
%disp(s1)
s2=feval(func,t+(timeStep/2),x+(timeStep/2)*s1,p);
%disp(s2)
s3=feval(func,t+(timeStep/2),x+(timeStep/2)*s2,p);
%disp(s3)
s4=feval(func,t+timeStep,x+(timeStep*s3),p);
%disp(s4)
result=x+(timeStep/6)*(s1+(2*s2)+(2*s3)+s4);
end
