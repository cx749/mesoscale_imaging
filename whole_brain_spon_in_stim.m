function [output] = whole_brain_spon_in_stim ()
load('movement-log');
load('whole brain trace');

[W_pks,still_period] = spon_after_stim(W_dff,movement_log);

output(1,1) = W_pks./(still_period./3000);
end