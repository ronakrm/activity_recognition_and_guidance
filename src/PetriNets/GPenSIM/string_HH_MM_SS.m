function [time_string] = string_HH_MM_SS(timex)
% function [time_string] = string_HH_MM_SS(timex)
%
hour = floor(timex/3600);
rest = mod(timex, 3600);
minute = floor(rest/60);
second = mod(rest, 60);

hour_str = num2str(hour);
if lt(hour, 10),
    hour_str = ['0', hour_str];
end;

min_str = num2str(minute);
if lt(minute, 10),
    min_str = ['0', min_str];
end;

sec_str = num2str(second);
if lt(second, 10),
    sec_str = ['0', sec_str];
end;

time_string = [hour_str,':', min_str, ':', sec_str];



