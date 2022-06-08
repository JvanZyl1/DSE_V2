import numpy as np
from simple_pid import PID
import matplotlib.pyplot as plt
# parameters (to be added to txt)
Cd = .2
A  = 3.5 # area in m2
m  = 827 # mass in kg
# u  = 20  # gust velocity in m/s
t  = 5000   # time of gust in s
tau = 0.01 # random time delay, https://link.springer.com/content/pdf/10.3103/S1068799816020045.pdf

# functions
def gust_velocity(t):
    ''''
    where period is 10.5 seconds
    :param: t in seconds
    :return: gust velocity according to easa standard in baseline
    '''
    T = 10.5
    if t < 0 or t>T:
        return 0
    return 12.4 - 13*np.sin(3*np.pi*t / T)*(1 - np.cos(2*np.pi*t / T))

def aero_force(cd, area, vel, rho):
    '''
    :param cd: relevant drag coefficient
    :param area: relevant area in m2
    :param vel: gust velocity in m.s
    :param rho: density in kg/m3
    :return: force in direction of gust velocity
    '''

    return .5*rho*(vel)**2*area*cd

# set up PID
pid = PID(0.1,.00,.01, setpoint=0, sample_time=.01)

# reaction

dt = .01
u_side = 0
posy = 0
positions = []
time = np.arange(0,t,dt)
velocity = []
a_drags = []
for i in np.arange(0,t,dt):
    a_back = 0
    if i > tau:
        #a_back = 0.001*pid(posy)
        # print(a_back)
        a_back = 0

    u_gust = gust_velocity(i)
    # relative velocity pushing the vehicle
    u_push = u_gust - u_side

    a_gust = aero_force(Cd, A, u_push, 1.225) / m
    if u_push<0:
        a_gust =-a_gust
    # NOW WE ASSUME SYMMETRICAL DRAG
    # a_drag = aero_force(Cd, A, u_side, 1.225) / m
    # resulting acceleration
    a = a_gust + a_back
    u_side += a*dt
    velocity.append(u_side)
    posy += u_side*dt
    positions.append(posy)

# plt.plot(time,velocity)
plt.plot(time,positions)
plt.show()
# plt.plot(time,a_drags)
# plt.show()
print(u_side, posy)



