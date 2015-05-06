function NewName = good_name(Name, String_size, JUSTIFY)
%       NewName = good_name(Name)
%       NewName = good_name(Name, String_size)
%       NewName = good_name(Name, String_size, JUSTIFY)
% 	To make the length of a string to predefined size.
% 	IF the input length is greater than the predefined size, 
%  then the string will be chopped. If the length is less,
%  then the string will be padded with blanks.
%
%		Uses: none

%     Last revision: 30 Jan, 00. (rd@hin.no)

if (nargin > 1), %string length given
    Name_String_Size = String_size;
else
    Name_String_Size = 10; % global string size
end;

if (nargin <= 2), % string justify not given
    char_justify = 'l';
else
    char_justify = lower(JUSTIFY);
end;
       
lenN = length(Name); % name
spaces = blanks(Name_String_Size);
NewName = spaces;

if lenN >= Name_String_Size, 
   NewName = Name(1:Name_String_Size); 
   
else   %lenN < Name_String_Size,
   switch (char_justify)
       case 'l'
           NewName(1:lenN) = Name;
       case 'c' 
           left_bl = round(lenN/2);
           right_bl = left_bl;
           if mod(lenN, 2),
               if lenN > (left_bl+right_bl),
                   left_bl = left_bl+1;
               elseif lenN < (left_bl+right_bl),
                   left_bl = left_bl-1;
               end; 
           end;
           NewName = [blanks(left_bl) Name blanks(right_bl)];
           
       case 'r'
           NewName = [blanks(Name_String_Size - lenN) Name];
       otherwise
          disp('Unknown justification in Good_Name')
   end;
end;

