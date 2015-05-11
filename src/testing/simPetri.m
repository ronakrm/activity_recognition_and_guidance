function [ next ] = simPetri( cur )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

switch cur
    case 1
        next = [1];
    case 2
        next = [2;3];
    case 3
        next = [2;3];
    case 4
        next = [4];
    case 5
        next = [5;6];
    case 6
        next = [5;6];
    case 7
        next = [7];
    case 8
        next = [8];
    otherwise
        next = ['JOFNKEFNEWJGW'];
end
end

