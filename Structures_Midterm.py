"""
DSE: Structures
Beam Loading and Stresses
"""

from math import *
import numpy as np
from matplotlib import pyplot as plt

W_beam = 200  # N
L = 0  # N
W_engine = 1000  # N

d = 2  # m
t = 1e-3  # m
r = 0.1  # m

Ixx = t * r ** 3  # m**4

# Functions
dx, dy, dz = 0.005, 0.005, 0.01
x = np.arange(-r, r, dx)
y = np.arange(-r, r, dy)
z = np.arange(0, d + dz, dz)


# Internal Load Function along z-axis
def v_beam(W_beam, W_engine, d, z, L):
    """

    :param W_beam: Weight of the beam
    :param W_engine: Weight of one engine
    :param d: Length of the beam
    :param z: z-axis along length of beam
    :param L: Total Lift
    :return: Internal Load
    """
    Vz = W_beam + W_engine - L / 4 - W_beam * z / d
    return Vz


# Moment Function along z-axis
def m_beam(W_beam, W_engine, d, z, L):
    M_a = (W_beam / 2 + W_engine - L / 4) * d
    Mz = (W_beam + W_engine - L / 4) * z - W_beam * z ** 2 / (2 * d) - M_a
    return Mz


# Bending stress along x- and z-axis
def stress_beam(W_beam, W_engine, d, z, L, x, Ixx):
    sigma_x = np.transpose([(m_beam(W_beam, W_engine, d, z, L) / Ixx)]) * [x]
    return sigma_x


# Shear stress
def shear_beam(W_beam, W_engine, d, z, L, x, Ixx, t, r):
    Vz = v_beam(W_beam, W_engine, d, z, L)
    tau = np.transpose([Vz])/(-pi * t * r**4) * [x]
    return tau







def v_wing():
    pass


def m_wing():
    pass


# Functions
Vz = v_beam(W_beam, W_engine, d, z, L)
Mz = m_beam(W_beam, W_engine, d, z, L)
sigma_x = stress_beam(W_beam, W_engine, d, z, L, x, Ixx)
tau = shear_beam(W_beam, W_engine, d, z, L, x, Ixx, t, r)

print(tau)


# Plot(s)
plt.plot(tau[0], x)
plt.show()
