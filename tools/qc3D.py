"""
QLC TOPOLOGY VISUALIZER: Seeing the Logic

This tool projects a discrete QuCalc history string into a 3D space 
so users can visually comprehend Zero Free Action (ZFA) closure. 

Dependencies: pip install matplotlib
"""

import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

class TopologyVisualizer:
    def __init__(self, history_string):
        self.history = history_string
        
        # Mapping relational distinction-pairs to a 3D projection for visualization.
        # Note: In pure QLF, these are local/relative. For visualization purposes,
        # we map them to an arbitrary macroscopic observer's XYZ frame.
        self.PROJECTION_MAP = {
            '^': (0, 0, 1),  'v': (0, 0, -1),  # Vertical Distinction (Z-axis)
            '<': (-1, 0, 0), '>': (1, 0, 0),   # Horizontal Distinction (X-axis)
            '/': (0, 1, 0),  '\\': (0, -1, 0), # Depth Distinction (Y-axis)
            '+': (0, 0, 0),  '-': (0, 0, 0)    # Contextual (Does not shift spatial locus)
        }

    def generate_path(self):
        """Translates the history string into a series of 3D coordinates."""
        x, y, z = [0], [0], [0]  # All paths originate at the logical Void (0,0,0)
        
        current_x, current_y, current_z = 0, 0, 0
        
        for twist in self.history:
            dx, dy, dz = self.PROJECTION_MAP.get(twist, (0, 0, 0))
            current_x += dx
            current_y += dy
            current_z += dz
            
            x.append(current_x)
            y.append(current_y)
            z.append(current_z)
            
        return x, y, z

    def is_zfa(self, x, y, z):
        """Checks if the topological path returns perfectly to the origin."""
        return x[-1] == 0 and y[-1] == 0 and z[-1] == 0

    def render(self, title="QuCalc Topological Path"):
        """Renders the 3D directed graph of the history string."""
        x, y, z = self.generate_path()
        closed_loop = self.is_zfa(x, y, z)
        
        fig = plt.figure(figsize=(10, 8))
        ax = fig.add_subplot(111, projection='3d')
        
        # Plot the topological history
        ax.plot(x, y, z, marker='o', color='b', markersize=4, linestyle='-', linewidth=2, label='Logical Path')
        
        # Mark the Origin / ZFA Point
        ax.scatter([0], [0], [0], color='green', s=100, label='Logical Origin (Void)')
        
        # If it doesn't close, mark the un-canceled free action endpoint
        if not closed_loop:
            ax.scatter([x[-1]], [y[-1]], [z[-1]], color='red', s=100, label='Un-canceled Free Action')
            status = "Status: OPEN (Free Action / Radiation)"
        else:
            status = "Status: CLOSED (Zero Free Action / Stable Mass)"

        ax.set_title(f"{title}\nString: {self.history}\n{status}")
        ax.set_xlabel('Horizontal (< >)')
        ax.set_ylabel('Depth (/ \\)')
        ax.set_zlabel('Vertical (^ v)')
        ax.legend()
        plt.show()

# --- Example Invocations ---
if __name__ == "__main__":
    # Example 1: An open radiative string (Photon)
    photon_string = "^^^^<<<<////"
    vis_photon = TopologyVisualizer(photon_string)
    # vis_photon.render("Free Action Projection") # Uncomment to view

    # Example 2: A closed, stable knot (Fermion / Mass)
    fermion_string = "^>v<^>v<^^>><<vv"
    vis_fermion = TopologyVisualizer(fermion_string)
    vis_fermion.render("Bound Action Projection (Stable ZFA Loop)")
