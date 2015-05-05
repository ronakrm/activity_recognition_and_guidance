function [] = plotTime(simRESULTS, common_events)
% [] = plotTime(simRESULTS, common_events)

if (nargin > 1),    
    commonEvents_m = elements_matrix(simRESULTS.global_transitions, common_events);
else
    commonEvents_m = zeros(1, length(simRESULTS.global_transitions));
end;

[m,n] = size(simRESULTS.LOG);
X = simRESULTS.LOG(2:m, [n-3:n]);
m = m-1; n = 4;

if any(commonEvents_m),
    first_CE = find(commonEvents_m); first_CE = first_CE(1);
end;

for i=1:m, 
    current_event=X(i,1);        
    if commonEvents_m(current_event),   X(i, 1)=first_CE;
    end;
end;

for i=2:m, 
    parent = X(i,2);
    former_event = X(parent,1);
    if commonEvents_m(former_event),  X(i, 2) = first_CE;
        else X(i, 2) = former_event;
    end;
end;

max_event = max(X(:,1)); max_time = max(X(:,4));
figure, axis([0 (max_time*1.2) 0 max_event+1]), hold on;

for i=1:m,
    event = X(i, 1);    startT= X(i, 3);    stopT = X(i, 4);
    vector = startT:0.01:stopT; 
    plot(vector, event, 'r-');
end;

for i=2:m,
    startT= X(i, 3);    currentEvent = X(i, 1);    formerEvent = X(i, 2);
    if (currentEvent < formerEvent) vector = currentEvent:0.05:formerEvent;
        else vector = formerEvent:0.05:currentEvent;
    end;
    plot(startT, vector, 'b--');
end;

hold off;
