"""
cp_violation_sim.py
Quantum Logical Framework - Evolutionary Ecology Simulation
Demonstrates Spontaneous CP Violation via Markov Blanket Clustering
"""

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
import matplotlib.animation as animation

# --- Simulation Parameters ---
GRID_SIZE = 75
EMPTY = 0
MATTER = 1
ANTIMATTER = -1

# The "Markov Blanket" parameters:
BASE_REP_RATE = 0.05    # Base chance for an isolated closure to replicate
CLUSTER_BONUS = 0.15    # Extra replication chance per friendly neighbor (Active Inference)

# --- Initialize the Possibilist Arena ---
# Start with a very sparse, perfectly balanced 50/50 universe
grid = np.zeros((GRID_SIZE, GRID_SIZE), dtype=int)
initial_density = 0.1
for i in range(GRID_SIZE):
    for j in range(GRID_SIZE):
        if np.random.rand() < initial_density:
            grid[i, j] = MATTER if np.random.rand() < 0.5 else ANTIMATTER

def get_neighbors(x, y):
    """Return coordinates of the 4 von Neumann neighbors with periodic boundary (torus topology)."""
    return [
        ((x + 1) % GRID_SIZE, y),
        ((x - 1) % GRID_SIZE, y),
        (x, (y + 1) % GRID_SIZE),
        (x, (y - 1) % GRID_SIZE)
    ]

def step(frameNum, img, grid):
    """One generation of the QuCalc evolutionary game."""
    new_grid = grid.copy()
    
    # We randomize the evaluation order to prevent directional bias
    xs, ys = np.meshgrid(np.arange(GRID_SIZE), np.arange(GRID_SIZE))
    coords = list(zip(xs.flatten(), ys.flatten()))
    np.random.shuffle(coords)
    
    for x, y in coords:
        current_state = grid[x, y]
        if current_state == EMPTY:
            continue
            
        neighbors = get_neighbors(x, y)
        np.random.shuffle(neighbors) # Pick a random direction to interact
        
        # Count friendly neighbors to calculate the Markov Blanket defense/energy
        friendly_count = sum(1 for nx, ny in neighbors if grid[nx, ny] == current_state)
        
        # Attempt to interact with one random neighbor
        nx, ny = neighbors[0]
        target_state = grid[nx, ny]
        
        if target_state == -current_state:
            # 1. ZFA Annihilation: Perfect conjugate matching
            new_grid[x, y] = EMPTY
            new_grid[nx, ny] = EMPTY
            
        elif target_state == EMPTY:
            # 2. RhoQuCalc Replication (*P):
            # The replication probability is dramatically boosted by the Markov Blanket
            rep_chance = BASE_REP_RATE + (CLUSTER_BONUS * friendly_count)
            if np.random.rand() < rep_chance:
                new_grid[nx, ny] = current_state
                
    # Update the actual grid
    grid[:] = new_grid[:]
    img.set_data(grid)
    
    # Track the population to print to console
    m_count = np.count_nonzero(grid == MATTER)
    a_count = np.count_nonzero(grid == ANTIMATTER)
    if frameNum % 10 == 0:
        print(f"Generation {frameNum:04d} | Matter: {m_count} | Antimatter: {a_count}")
        
    return img,

# --- Visualization Setup ---
fig, ax = plt.subplots(figsize=(8, 8))
# Black = Empty, Blue = Matter, Red = Antimatter
cmap = mcolors.ListedColormap(['red', 'black', 'blue'])
bounds = [-1.5, -0.5, 0.5, 1.5]
norm = mcolors.BoundaryNorm(bounds, cmap.N)

img = ax.imshow(grid, cmap=cmap, norm=norm, interpolation='nearest')
ax.set_title("QLF Active Inference Ecology:\nMatter (Blue) vs Antimatter (Red)")
ax.axis('off')

print("Starting simulation... Watch the symmetry break!")
ani = animation.FuncAnimation(fig, step, fargs=(img, grid),
                              frames=1000, interval=50, save_count=50)

plt.show()
