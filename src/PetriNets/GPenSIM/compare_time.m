function [ct] = compare_time (time1, TIME2)
% function [ct] = compare_time (time1, time2)
%
% returned values:
% ct = -1, if time1 < time2
% ct = 0,  if time1 = time2
% ct = +1, if time1 > time2

% standardize time1
if ischar (time1),  % time is a string; e.g. 'unifrdn(10, 12)'
    stime1 = eval(time1); 
elseif eq(length(time1), 3),  % time is vector [hh mm ss]
    stime1 = time1(3) + (60 * time1(2)) + (60 * 60 * time1(1)); % convert to seconds
else
    stime1 = time1;
end;

% standardize time2
if ischar (TIME2),  % time is a string; e.g. 'unifrdn(10, 12)'
    STIME2 = eval(TIME2); 
elseif eq(length(TIME2), 3),  % time is vector [hh mm ss]
    STIME2 = TIME2(3) + (60 * TIME2(2)) + (60 * 60 * TIME2(1)); % convert to seconds
else
    STIME2 = TIME2;
end;

% finally, compare
if lt(stime1, STIME2),
    ct = -1;
elseif eq(stime1, STIME2),
    ct = 0;
else
    ct = 1;
end;




    