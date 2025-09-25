using Printf
# wavesim.jl
# Simple simulation of a damped harmonic oscillator in Julia

# Parameters
m = 1.0        # mass (kg)
k = 4.0        # spring constant (N/m)
c = 0.2        # damping coefficient
x0 = 1.0       # initial displacement (m)
v0 = 0.0       # initial velocity (m/s)
dt = 0.01      # time step (s)
tmax = 10.0    # total simulation time (s)

# Acceleration function: a = ( -k*x - c*v ) / m
function acceleration(x, v)
    return (-k * x - c * v) / m
end

# Time evolution with Euler's method
function simulate(x0, v0, dt, tmax)
    steps = Int(round(tmax / dt))
    x = x0
    v = v0
    results = Vector{Tuple{Float64,Float64,Float64}}()  # store (t, x, v)

    for i in 0:steps
        t = i * dt
        push!(results, (t, x, v))

        # update using Euler method
        a = acceleration(x, v)
        v += a * dt
        x += v * dt
    end

    return results
end

# Run the simulation
results = simulate(x0, v0, dt, tmax)

# Print first 20 time steps nicely
println(" time (s)    position (m)    velocity (m/s) ")
println("--------------------------------------------")
for (t, x, v) in results[1:20]
    @printf("%8.3f    %12.6f    %12.6f\n", t, x, v)
end

