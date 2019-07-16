function [data_base, treatment_type] = identify_database(data)

if data == 0 
data_base = developmentalrecordings;
treatment_type = 0;
else if data == 1
data_base = whiskertrimmedrecordings;
treatment_type = 1;
    else 
       error('Database missing or of unknown layout') 
end

end