function [dynamicpart] = initialdynamics (filename)
%% [dynamicpart]=initialdynamicsn(filename)


funcname = [filename];
filename = [filename '.m'];

if exist(filename, 'file'),
    [dynamicpart] = feval(str2func(funcname));
else
    dynamicpart = struct([]);
end;
