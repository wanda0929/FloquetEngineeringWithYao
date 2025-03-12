using Test
using FloquetdrivingWithYao
using Yao
@testset "periodic_square_lattice" begin
    nx = 5
    ny = 5
    nq = nx * ny
    @test length(periodic_square_lattice(nx, ny)) == 12

    
end

@testset "FloquetDrive" begin
    t = 0.5
    amplitude = 3.0
    frequency = 2.0
    phase = 0
    @test floquet_drive(t, amplitude, frequency,phase) == 3.0 * cos(2.0 * 0.5)
end
    

@testset "Circuitwithyao" begin
    nx = 2      
    ny = 2
    nq = nx * ny
    step = 100
    nlayers = step
    t = 1.0
    Omega_1 = 1.0
    Omega_4 = 1.0
    topology = periodic_square_lattice(nx, ny)
    coupling_strength = ones(length(topology))
    circuit = circuitwithyao(t, nq, nlayers, Omega_1, Omega_4, coupling_strength, topology)
    expected_length = nlayers * (length(topology) + 2)
    @test length(circuit) == expected_length
end 