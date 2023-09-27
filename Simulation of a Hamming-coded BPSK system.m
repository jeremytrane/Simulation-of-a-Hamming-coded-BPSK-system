%Assignment 2 EEEN40060
clear;
clc;

% Constants
N = 1e6;
k = 4;
n = 7;
Eb_N0_dB = 0:1:10;

% Matrices
A = [1 1 0; 0 1 1; 1 1 1; 1 0 1];
G = [A eye(k)];
H = [eye(n-k) A'];

% Noise and energy
Eb_N0_dB_lin = 10.^(Eb_N0_dB/10);
sigma = 1;
N0 = 2*sigma^2;
eb = Eb_N0_dB_lin * N0;
ec = eb * (k/n);

% Hamming 7,4 Decoding
syndrome_lookup = [0,0,0;0,0,1;0,1,0;0,1,1;1,0,0;1,0,1;1,1,0;1,1,1];
error_vector = [0,0,0,0,0,0,0;0,0,1,0,0,0,0;0,1,0,0,0,0,0;0,0,0,0,1,0,0;1,0,0,0,0,0,0;0,0,0,0,0,0,1;0,0,0,1,0,0,0;0,0,0,0,0,1,0];

number_of_errors = zeros(1, length(Eb_N0_dB));

for x = 1:length(Eb_N0_dB)
    disp(['Iteration: ' num2str(x)]);
    
    % Generate random data
    data = rand(1,N) > 0.5;
    data_split = reshape(data, 4, N/4).';
    
    % Encoding and modulation
    codeword = mod(data_split * G, 2);
    codewordM = codeword * 2 - 1; % Convert 0s to -1 and 1s remain 1
    codewordM = codewordM * sqrt(ec(x));
    
    % Add noise
    noise = sqrt(N0/2) * randn(N/4, 7);
    codewordM_noise = codewordM + noise;
    
    % Receiver 
    codeword_received = codewordM_noise > 0;
    
    % Hamming decoder
    syndrome = mod(codeword_received * H', 2);
    [~, RowIdx] = ismember(syndrome, syndrome_lookup, 'rows');
    error_vec = error_vector(RowIdx,:);
    codeword_received_corrected = mod(codeword_received + error_vec, 2);
    
    % Count errors
    number_of_errors(x) = sum(sum(codeword_received_corrected(:, k:n) ~= codeword(:, k:n)));
end

% Results
BER_theoretical = 0.5 * erfc(sqrt(10.^(Eb_N0_dB/10)));
BER_simulated = number_of_errors/N;

% Plot
figure;
semilogy(Eb_N0_dB, BER_theoretical, 'bd-', 'LineWidth', 1);
hold on;
semilogy(Eb_N0_dB, BER_simulated, 'ms-', 'LineWidth', 1);
grid on;
legend('theory - uncoded', 'simulation - Hamming 7,4');
xlabel('Eb/No, dB');
ylabel('Bit Error Rate');
title('BER for BPSK in AWGN with Hamming (7,4) code');
