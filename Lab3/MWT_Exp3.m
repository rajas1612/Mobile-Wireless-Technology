clc
clear all;
len=input("Enter Length of a sequence: ");
input_seq  = randi([0 1],1,len);
fprintf("Input Sequence:");
disp(input_seq);
pn_sig_gen = round(rand(1,len)); % generate random 0 and 1 for the length of input signal
fprintf("Pseudorandom Sequence:")
disp(pn_sig_gen);
total_data = 1:length(input_seq); % 1 to len of input
total_pn = 1:length(pn_sig_gen); % 1 to length of pn
spread_bits = input("Enter spread bits: ");
mul_seq = bitxor(input_seq, pn_sig_gen); % bitwise xor of input and pr sequence
fprintf("Multiplied Sequence:")
disp(mul_seq);
chip = spreading(mul_seq,spread_bits); % chip sequence
fprintf("Chip Sequence:")
disp(chip);
t=0:0.1:2*pi;
carrier_wave = sin(t);
bpsk = [];
for i = 2:length(chip)
    if chip(i) == 1
        bpsk = cat(2, bpsk, carrier_wave); % positive cycle
    else
        bpsk = cat(2, bpsk, -carrier_wave); % negative cycle
    end
    %=[bpsk bpsk1];
end
figure(1);
subplot(5,1,1);
stairs([input_seq,input_seq(end)],'linewidth',2);
axis([1 len+5 -2 2]);
title('ORIGINAL BIT SEQUENCE b(t)');
subplot(5,1,2);
stairs([pn_sig_gen,pn_sig_gen(end)],'linewidth',2);
axis([1 length(pn_sig_gen)+5 -2 2]);
title('PSEUDORANDOM BIT SEQUENCE pr_sig(t)');
subplot(5,1,3);
stairs([mul_seq,mul_seq(end)],'linewidth',2);
axis([1 length(mul_seq)+5 -2 2]);
title('MULTIPLIED SIGNAL');
subplot(5,1,4);
stairs([chip,chip(end)],'linewidth',2);
axis([1 length(chip)+5 -2 2]);
title('CHIP SEQUENCE');
subplot(5,1,5);
plot(bpsk);
axis([1 length(bpsk)+5 -2 2]);
title('BPSK SIGNAL');

figure(2);
subplot(2,1,1)
stairs([chip,chip(end)],'linewidth',2);
axis([1 length(chip)+5 -2 2]);
title('CHIP SEQUENCE');
plot(bpsk);
axis([1 length(bpsk)+5 -2 2]);
title('BPSK SIGNAL');

function cs = spreading(mul,inp)
    cs =[];
    for i = 1:length(mul)
        t = [];
        for j = 1:inp
            t = cat(2, t, mul(i)); % 2 for horizontal concatnation
        end
        cs = cat(2, cs, t);
    end
end

