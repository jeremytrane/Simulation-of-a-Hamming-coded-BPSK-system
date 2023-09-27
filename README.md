# Hamming-coded BPSK System Simulation

This repository contains MATLAB code for simulating a Hamming-coded BPSK system. The goal of this simulation is to understand the performance improvements introduced by error-correcting codes, specifically the Hamming (7,4) code, over a noisy communication channel. 

## Overview

- **BPSK Modulation**: Binary Phase Shift Keying (BPSK) is a type of digital modulation technique where the phase of the carrier is varied in accordance with the input data bits.
  
- **Hamming (7,4) Code**: The Hamming (7,4) code is an error-correcting code that encodes 4 bits of data into 7 bits by adding 3 parity bits. This enables the correction of single-bit errors, thus enhancing the reliability of data transmission over noisy channels.

## Features

- Generates random data for transmission.
- Encodes data using Hamming (7,4) code.
- Modulates the encoded data using BPSK.
- Simulates transmission over an Additive White Gaussian Noise (AWGN) channel.
- Decodes the received data using the Hamming code to correct errors.
- Compares the Bit Error Rate (BER) of the encoded data against the theoretical BER of uncoded data.

## How to Run

1. Ensure you have MATLAB installed on your machine.
2. Clone this repository: https://github.com/jeremytrane/Simulation-of-a-Hamming-coded-BPSK-system.git
3. Navigate to the directory containing the MATLAB code.
4. Open MATLAB and run the code.

## Results

The code plots the Bit Error Rate (BER) of the Hamming-coded BPSK system against the theoretical BER of an uncoded BPSK system. This visualizes the improvements brought by the Hamming code in terms of error performance.

## License

MIT, GPL

## Contributors

- Jeremy Trane

