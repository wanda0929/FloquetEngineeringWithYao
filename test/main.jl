using Main.FloquetdrivingWithYao
using Yao
#定义x，y方向的spin数量及拓扑结构
nx = 2      
ny = 2
nq = nx * ny
topology = periodic_square_lattice(nx, ny)
amplitude = 1.0
omega = 2*π
phase = 0.0
t = 1.0
Omega_1 = 1.0
Omega_4 = 1.0
nlayers = 100

initial_amplitudes = zeros(Complex{Float64}, 2^nq)
initial_amplitudes[0b0000 + 1] = 1.0
state = ArrayReg(initial_amplitudes)

for time_t in 0:t/nlayers:t
    J_1 = floquet_drive(time_t, amplitude, omega, phase)
    J_2 = floquet_drive(time_t, amplitude, 2*omega, phase)
    coupling_strength = [J_1 ,J_2 ,J_2]
    circuit_blocks = circuitwithyao(time_t, nq, nlayers, Omega_1, Omega_4, coupling_strength, topology)
    circuit = chain(circuit_blocks...)
    finalstate = apply!(state, circuit)
    state = finalstate
end
final = normalize!(state)
stt = statevec(final)
pauli_z = [1.0 0.0; 0.0 -1.0]
iden = [1.0 0.0; 0.0 1.0]
op = kron(iden, pauli_z, iden, iden)
transpose(stt) * op * stt
#expectation_values = expect(op, final)


    