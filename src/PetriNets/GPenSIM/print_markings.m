function [] = print_markings(markings)

% [] = print_markings(markings)
no_places = length(markings);
large_str = [' '];
for i = 1:no_places,
    tokens = markings(i);
    tokens_str = good_name(num2str(tokens));
    large_str = [large_str tokens_str];
end;

disp(large_str);
