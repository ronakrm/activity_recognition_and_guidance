function [et] = event_random_timing(name, parameter1, parameter2)
%% [et] = event_random_timing(name, parameter1, parameter2)
%% 
%% name is the name of the distribution 
%% 
%% Only the following distributions are supported:
%%      Guassian/Normal, Binomial, Poisson, Uniform
%% Uses random function from statistical toolbox

%% RD  (c) 17 feb 2006

if nargin==2,
    % e.g. poissrnd(5)
    string1 = strcat('random(''', name, ''',', num2str(parameter1), ')');
    et = eval(string1);
elseif nargin==3,
    % e.g. unifrnd(100, 200)
    string2 = strcat('random(''', name, ''',', num2str(parameter1), ...
        ',', num2str(parameter2),')');
    et = eval(string2);
end;

