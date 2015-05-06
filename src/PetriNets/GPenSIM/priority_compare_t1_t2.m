% function [HEL] = priority_compare_t1_t2(PList, t1, t2) 
% % function [HEL] = priority_compare_t1_t2(PList, t1, t2) 
% %
% % This function compares priority of t1 with t2.
% %
% % Inputs:   PList : priority list from PN structure
% %           t1, t2: transition numbers
% % Output:   HEL = 1  if priority of t1 > t2
% %           HEL = 0  if priority of t1 = t2
% %           HEL = -1 if priority of t1 < t2
% 
% index_1 = find(PList==t1);
% index_2 = find(PList==t2);
% 
% % HEL:  High, Equal or Low proirity
% 
% if and(index_1, index_2),  % both indices are in the PList
%     if lt(index_1, index_2),
%         HEL = 1;   % t1 > t2
%     else  
%         HEL = -1;  % t1 < t2
%     end;
% else  % either one of them or both indices are not in PList
%     if (index_1),
%         HEL = 1;   % t1 in Plist; t2 NOT in Plist; thus, t1 > t2
%     elseif (index_2),
%         HEL = -1;  % t2 in Plist; t1 NOT in Plist; thus, t2 > t1
%     else
%         HEL = 0;
%     end;
% end;
