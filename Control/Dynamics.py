import numpy as np
import matplotlib.pyplot as plt
import math

def read_txt(file):
    '''
    This function reads the file  to create a dictonary

    return: dict - a dictionary of all the constants
    '''
    new_dict = {}
    file_reading = open(str(file), "r") #open the file
    freq = file_reading.readlines()  #read the lines
    for line in freq:
        row = line.split()
        new_dict[str(row[0])] = float(row[1])
    return new_dict

def read_configuration(file):
    '''
    This function reads the file  to create a nested dictionary

    param: file - input txt file to read

    return: w_dict - a nested dictionary
    '''
    w_dict = {}
    file_reading = open(str(file), "r") #open the file
    freq = file_reading.readlines()  #read the lines
    names = []
    for line in freq:
        row = line.split()
        if row[0] not in names:
            names.append(row[0])
    for i in range(len(names)):
        w_dict[names[i]] = {}
    for line in freq:
        row = line.split()
        w_dict[row[0]][row[1]] = float(row[2])
    return w_dict

def T_x(a, mat):
    '''
    This function performs a tranformation around the x-axis

    param: a - x rotation angle [radians]
    param: mat - matrix or vector to rotate

    return mat_rot_x - rotated matrix or vector
    '''
    Tx = np.matrix([[1,0,0],[0,math.cos(a),math.sin(a)],[0,-1*math.sin(a),math.cos(a)]])
    mat_rot_x = Tx*mat
    return mat_rot_x


def T_y(b, mat):
    '''
    This function performs a transformation around the y-axis

    param: b - y rotation angle [radians]
    param: mat - matrix or vector to rotate

    return mat_rot_y - rotated matrix or vector
    '''
    Ty = np.matrix([[math.cos(b),0,-1*math.sin(b)],[0,1,0],[math.sin(b),0,math.cos(b)]])
    mat_rot_y = Ty*mat
    return mat_rot_y

def T_z(c, mat):

    '''
    This function performs a transformation around the z-axis

    param: c - z rotation angle [radians]
    param: mat - matrix or vector to rotate

    return mat_rot_z - rotated matrix or vector
    '''
    Tz = np.matrix([[math.cos(c), math.sin(c), 0],
    [-math.sin(c), math.cos(c), 0],
    [0, 0, 1]])
    #Tz = np.matrix([[np.cos(c), np.sin(c), 0], [-np.sin(c), np.cos(c), 0], [0, 0, 1]])
    mat_rot_z = Tz*mat
    return mat_rot_z

def T_zyx(a,b,c,mat):
    '''
    This function performs the z-y-x aerospace standard for transformations

    param: a - x rotation angle [radians]
    param: b - y rotation angle [radians]
    param: c - z rotation angle [radians]
    param: mat - matrix or vector to rotate

    return Tzyx - rotated matrix or vector
    '''
    Tz = T_z(c, mat)
    Tzy = T_y(b, Tz)
    Tzyx = T_x(a, Tzy)
    return Tzyx

def Euler_rot(initial_conds_dict, constant_dict, config_dict, M_aero, F_control):
    '''
    This function performs the Euler rotation

    param: initial_conds_dict - the starting point for the calculation, dictionary
    param: constant_dict - the constants in a dictionary
    param: config_dict - the configuration dictionary
    param: M_aero - aerodynamic moments
    param: F_control - control forces

    return: w_dot - the angular accleration vector
    
    '''
    w_vec = np.matrix([[float(initial_conds_dict["w_x_0"])], [float(initial_conds_dict["w_y_0"])], [float(initial_conds_dict["w_z_0"])]]) #Angular velocity vector
    
    #r_cp_cg = np.matrix([[config_dict["x_cg_cp"]], [config_dict["y_cg_cp"]], [config_dict["z_cg_cp"]]])
    I = constant_dict["I_mat"]  #Inertia matrix
    H = np.matmul(I, w_vec) #Angular momentum
    w_cross_H = (np.cross(w_vec.T, H.T)).T
    d_arm = np.matrix([[config_dict["quadcopter"]["x_1"], config_dict["quadcopter"]["y_1"], config_dict["quadcopter"]["z_1"]], [config_dict["quadcopter"]["x_2"], config_dict["quadcopter"]["y_2"], config_dict["quadcopter"]["z_2"]], [config_dict["quadcopter"]["x_3"], config_dict["quadcopter"]["y_3"], config_dict["quadcopter"]["z_3"]]])
    M_control = np.dot(d_arm, F_control) #Control moment
    #w_dot = np.matrix([[initial_conds_dict["w_dotx_0"]], [initial_conds_dict["w_doty_0"]], [initial_conds_dict["w_dotz_0"]]])
    part_1 = M_control + M_aero - w_cross_H
    w_dot = np.matmul(constant_dict["I_inv"], part_1) #Angular accleration vector
    return w_dot

def linear_dynamics(constant_dict, F_control, F_aero):
    '''
    Finds the accleration.

    param: F_control - control force, including mass force
    param: F_aero - aerodynamic force
    
    return: acceleration - the linear acceleration
    '''
    acceleration = np.add(F_control, F_aero)*1/constant_dict["m"]
    return acceleration

def angular_simulation(config_dict, M_aero, F_control, constant_dict, delta_t, v_0, r_0, w_0, theta_0, v_dot, euler_rot, calculation_dict):
    '''
    This is the kinematics block

    param: config_dict - propulsive arms
    param: M_aero - aerodynamic moments [N]
    param: F_control - control force [N]
    param: constant_dict - dictionary of constants
    param: delta_t - time step [s]
    param: v_0 - initial velocity vector
    param: r_0 - initial position vector
    param: w_0 - initial angular velocity vector
    param: theta_0 - initial angle vector
    param: v_dot - initial acceleration vector
    param: euler_rot - dictionary for starting Euler_rot function
    param: calculation_dict - for storing values

    return: calculation_dict
    '''
    v_jplus1 = v_0 + np.multiply(v_dot,delta_t)
    calculation_dict["v_x_0"] = v_jplus1[0]
    calculation_dict["v_y_0"] = v_jplus1[1]
    calculation_dict["v_z_0"] = v_jplus1[2]
    calculation_dict["v_0"] = v_jplus1

    r_jplus1 = r_0 + v_jplus1*delta_t
    calculation_dict["r_x_0"] = r_jplus1[0]
    calculation_dict["r_y_0"] = r_jplus1[1]
    calculation_dict["r_z_0"] = r_jplus1[2]
    calculation_dict["r_0"] = r_jplus1

    w_dot = Euler_rot(euler_rot, constant_dict, config_dict, M_aero, F_control)
    calculation_dict["alpha_x_0"] = w_dot[0]
    calculation_dict["alpha_y_0"] = w_dot[1]
    calculation_dict["alpha_z_0"] = w_dot[2]
    calculation_dict["alpha_0"] = w_dot

    w_jplus1 = w_0 + w_dot*delta_t
    calculation_dict["w_x_0"] = w_jplus1[0]
    calculation_dict["w_y_0"] = w_jplus1[1]
    calculation_dict["w_z_0"] = w_jplus1[2]
    calculation_dict["w_0"] = w_jplus1

    theta_jplus1 = theta_0 + w_jplus1*delta_t
    calculation_dict["theta_x_0"] = theta_jplus1[0]
    calculation_dict["theta_y_0"] = theta_jplus1[1]
    calculation_dict["theta_z_0"] = theta_jplus1[2]
    calculation_dict["theta_0"] = theta_jplus1

    return calculation_dict

def rot_inertia(w_0, delta_t, constant_dict):
    '''
    This rotates the inertia

    param: w_0 - angular acceleration at start of time_step
    param: delta_t - time step
    param: constant_dict

    return: constant_dict - with updated inertia
    '''
    I = constant_dict["I_mat"]
    dtheta = np.dot(w_0, delta_t) #Change in angle
    T_z = np.matrix([[math.cos(dtheta[2]), math.sin(dtheta[2]), 0],
    [-math.sin(dtheta[2]), math.cos(dtheta[2]), 0],
    [0, 0, 1]])
    Ty = np.matrix([[math.cos(dtheta[1]),0,-1*math.sin(dtheta[1])],[0,1,0],[math.sin(dtheta[1]),0,math.cos(dtheta[1])]])
    Tx = np.matrix([[1,0,0],[0,math.cos(dtheta[0]),math.sin(dtheta[0])],[0,-1*math.sin(dtheta[0]),math.cos(dtheta[0])]])
    
    I_rotz = np.matmul(T_z, I)
    I_rotzy = np.matmul(Ty, I_rotz)
    I_rotzyx = np.matmul(Tx, I_rotzy)

    I_inv = np.linalg.inv(I_rotzyx)
    constant_dict["I_mat"] = I_rotzyx
    constant_dict["I_inv"] = I_inv
    return constant_dict

def angles(w_0, delta_t, F_dict, constant_dict):
    '''
    This function rotates the forces

    param: w_0 - the angular acclereation at the start of time step
    param: delta_t - time step
    param: F_dict - dictionary containing the forces
    
    return: F_rest_rot - rotated forces excluding control forces
    return: F_control_rot - rotated control forces
    '''
    F_x_total = sum(d['x'] for d in F_dict.values() if d)
    F_y_total = sum(d['y'] for d in F_dict.values() if d)
    F_z_total = sum(d['z'] for d in F_dict.values() if d)
    F_control_x = F_dict["control"]["x"]
    F_control_y = F_dict["control"]["y"]
    F_control_z = F_dict["control"]["z"]
    F_control_vec = np.matrix([[float(F_control_x)], [float(F_control_y)], [float(F_control_z)]])
    F_x_rest = F_x_total - F_control_x
    F_y_rest = F_y_total - F_control_y
    F_z_rest = F_z_total - F_control_z
    F_rest_vec = np.matrix([[float(F_x_rest)], [float(F_y_rest)], [float(F_z_rest)]])
    dtheta = np.dot(w_0, delta_t) #Change in angle
    F_rest_rot = T_zyx(dtheta[0],dtheta[1],dtheta[2],F_rest_vec)
    F_control_rot = T_zyx(dtheta[0],dtheta[1],dtheta[2],F_control_vec)
    # Update dictionary for forces TBD !!!!!!git 
    F_dict["control"]["x"] = float(F_control_rot[0])
    F_dict["control"]["y"] = float(F_control_rot[1])
    F_dict["control"]["z"] = float(F_control_rot[2])
    F_dict["aero"]["x"] = float(F_rest_rot[0])
    F_dict["aero"]["y"] = float(F_rest_rot[1])
    F_dict["aero"]["z"] = float(F_rest_rot[2])
    constant_dict = rot_inertia(w_0, delta_t, constant_dict)
    return F_rest_rot, F_control_rot, F_dict



def simulation(delta_t, constant_dict, time_span, initial_conds_dict, F_dict, M_aero, config_dict):
    '''
    This runs the simulation loop

    param: delta_t - the time step [s]
    param: constant_dict - dictionary of the constants
    param: time_span - the time span [s]
    param: initial_conds_dict - the initial conditions dictionary
    param: F_control - the control force [N]
    param: F_aero - the other forces [N]
    param: M_aero - the aerodynamic moments [Nm]
    param: config_dict - dictionary of moment arms

    return: output_dict - all the outputs in a dictionary: r,v,a,theta,omega,alpha    
    '''

    theta_0 = np.matrix([[initial_conds_dict["theta_x_0"]], [initial_conds_dict["theta_y_0"]], [initial_conds_dict["theta_z_0"]]]) #Initial angle
    w_0 = np.matrix([[initial_conds_dict["w_x_0"]], [initial_conds_dict["w_y_0"]], [initial_conds_dict["w_z_0"]]]) #Initial angular velocity vector
    r_0 = np.matrix([[initial_conds_dict["r_x_0"]], [initial_conds_dict["r_y_0"]], [initial_conds_dict["r_z_0"]]]) #Initial position vector
    v_0 = np.matrix([[initial_conds_dict["v_x_0"]], [initial_conds_dict["v_y_0"]], [initial_conds_dict["v_z_0"]]]) #Initial linear velocity vector
    
    time = np.arange(0, time_span, delta_t)

    v_x, v_y, v_z = [],[],[]
    r_x, r_y, r_z = [],[],[]
    w_x, w_y, w_z = [],[],[]
    theta_x, theta_y, theta_z = [],[],[]
    alpha_x, alpha_y, alpha_z = [],[],[]
    a_x, a_y, a_z = [],[],[]
    calculation_dict = {}

    F_aero = [[float(F_dict["aero"]["x"])], [float(F_dict["aero"]["y"])], [float(F_dict["aero"]["z"])]]
    F_control = [[float(F_dict["control"]["x"])], [float(F_dict["control"]["y"])], [float(F_dict["control"]["z"])]]

    for i in range(len(time)):
        v_dot = linear_dynamics(constant_dict, F_control, F_aero)
        calculation_dict["v_dot"] = v_dot
        calculation_dict["a_x_0"] = v_dot[0]
        calculation_dict["a_y_0"] = v_dot[1]
        calculation_dict["a_z_0"] = v_dot[2]

        if time[i] == 0:
            calculation_dict = angular_simulation(config_dict, M_aero, F_control, constant_dict, delta_t, v_0, r_0, w_0, theta_0, v_dot, initial_conds_dict, calculation_dict)
        else:
            calculation_dict = angular_simulation(config_dict, M_aero, F_control, constant_dict, delta_t, calculation_dict["v_0"], calculation_dict["r_0"], calculation_dict["w_0"], calculation_dict["theta_0"], calculation_dict["v_dot"], calculation_dict, calculation_dict)
        
        v_x.append(float(calculation_dict["v_x_0"]))
        v_y.append(float(calculation_dict["v_y_0"]))
        v_z.append(float(calculation_dict["v_z_0"]))

        r_x.append(float(calculation_dict["r_x_0"]))
        r_y.append(float(calculation_dict["r_y_0"]))
        r_z.append(float(calculation_dict["r_z_0"]))

        a_x.append(float(calculation_dict["a_x_0"]))
        a_y.append(float(calculation_dict["a_x_0"]))
        a_z.append(float(calculation_dict["a_z_0"]))

        w_x.append(float(calculation_dict["w_x_0"]))
        w_y.append(float(calculation_dict["w_y_0"]))
        w_z.append(float(calculation_dict["w_z_0"]))

        theta_x.append(float(calculation_dict["theta_x_0"]))
        theta_y.append(float(calculation_dict["theta_y_0"]))
        theta_z.append(float(calculation_dict["theta_z_0"]))

        alpha_x.append(float(calculation_dict["alpha_x_0"]))
        alpha_y.append(float(calculation_dict["alpha_y_0"]))
        alpha_z.append(float(calculation_dict["alpha_z_0"]))

        F_aero, F_control, F_dict = angles(calculation_dict["w_0"], delta_t, F_dict, constant_dict)

    output_dict = {'r_x':r_x, 'r_y':r_y, 'r_z':r_z, 'v_x': v_x, 'v_y': v_y, 'v_z': v_z, 'a_x':a_x, 'a_y':a_y, 'a_z':a_z, 
    'theta_x': theta_x, 'theta_y': theta_y, 'theta_z': theta_z, 'w_x': w_x, 'w_y': w_y, 'w_z': w_z, 'alpha_x': alpha_x,
    'alpha_y': alpha_x, 'alpha_y': alpha_y, 'alpha_z': alpha_z, 't': time}
    return output_dict


def run_code():
    '''
    This function runs the code.
    '''
    constant_dict = read_txt("Constants.txt")
    initialconds_dict = read_txt("Initial_Conditions.txt")
    config_dict = read_configuration("Propulsive_arms.txt")
    I = np.matrix([[constant_dict['I_xx'], constant_dict['I_xy'], constant_dict['I_xz']],
        [constant_dict['I_yx'], constant_dict['I_yy'], constant_dict['I_yz']],
        [constant_dict['I_zx'], constant_dict['I_zy'], constant_dict['I_zz']]])
    Iinv = np.linalg.inv(I)
    constant_dict["I_mat"] = I
    constant_dict["I_inv"] = Iinv

    F_dict = {"control":{"x": 0, "y": 0, "z":0.1},
    "aero":{"x":0, "y": 0, "z": 0}}
    M_aero = [[float(F_dict["aero"]["x"]*config_dict["quadcopter"]["x_cg_cp"])], [float(F_dict["aero"]["y"]*config_dict["quadcopter"]["y_cg_cp"])], [float(F_dict["aero"]["z"]*config_dict["quadcopter"]["z_cg_cp"])]]
    delta_t = (10)**(-1)
    time_span = 10
    output_dict = simulation(delta_t, constant_dict, time_span, initialconds_dict, F_dict, M_aero, config_dict)
    return output_dict

output_dict = run_code()

plt.figure(1)
plt.plot(output_dict["t"], output_dict["w_x"], '-g')
plt.plot(output_dict["t"], output_dict["w_y"], '-b')
plt.plot(output_dict["t"], output_dict["w_z"], '-r')
plt.legend(("x", "y","z"))
plt.xlabel("Time [s]")
plt.ylabel("angular velocity [m/s]")
plt.title("time-w")
plt.show()

plt.figure(2)
plt.plot(output_dict["t"], output_dict["theta_x"], '-g')
plt.plot(output_dict["t"], output_dict["theta_y"], '-b')
plt.plot(output_dict["t"], output_dict["theta_z"], '-r')
plt.legend(("x", "y","z"))
plt.xlabel("Time [s]")
plt.ylabel("angle [rad]")
plt.title("time-theta")
plt.show()


plt.figure(3)
plt.plot(output_dict["t"], output_dict["v_x"], '-g')
plt.plot(output_dict["t"], output_dict["v_y"], '-b')
plt.plot(output_dict["t"], output_dict["v_z"], '-r')
plt.legend(("x", "y","z"))
plt.xlabel("Time [s]")
plt.ylabel("Velocity [km/hr]")
plt.title("time-velocity")
plt.show()


### Check why the velocity is constant when a force is acting
### Look into aerodynamic inputs
### Look into adding drag
### Look into control force response
### Look to add sensors


