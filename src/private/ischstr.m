function is_chstr = ischstr(x)
%ISCHARSTR checks whether x is a "char" or "string".

is_chstr = isa(x, "char") || isa(x, "string");