# Example Keplerian fit configuration file
# Required packages for setup
import os
import pandas as pd
import numpy as np
import radvel
import os

# Define global planetary system and dataset parameters
starname = 'HD75732'
nplanets = 5   # number of planets in the system
instnames = ['k','j']    # list of instrument names. Can be whatever you like but should match 'tel' column in the input file.
ntels = len(instnames)       # number of instruments with unique velocity zero-points
fitting_basis = 'per tc secosw sesinw k'    # Fitting basis, see radvel.basis.BASIS_NAMES for available basis names
bjd0 = 0.0 
planet_letters = {1: 'a', 2:'b', 3:'c', 4:'d'}

# Define prior centers (initial guesses) here.
params = radvel.RVParameters(nplanets,basis='per tc e w k')    # initialize RVparameters object

params['per1'] = 14.65          # period of 1st planet
params['tc1'] = 2073.96         # time of inferior conjunction of 1st planet
params['e1'] = 0.02             # eccentricity of 'per tc secosw sesinw logk'1st planet
params['w1'] = np.pi/2.         # argument of periastron of the star's orbit for 1st planet
params['k1'] =  70.0876           # velocity semi-amplitude for 1st planet

params['per2'] =  4258.49       # period of 2nd planet
params['tc2'] = 3298.15         # time of inferior conjunction of 2nd planet
params['e2'] = 0.17            # eccentricity of 'per tc secosw sesinw logk' 2nd planet
params['w2'] = np.pi/2.         # argument of periastron of the star's orbit for 2nd planet
params['k2'] =  27.9438          # velocity semi-amplitude for 2nd planet

params['per3'] = 44.39          # period of 3rd planet
params['tc3'] = 2086.84         # time of inferior conjunction of 3rd planet
params['e3'] = 0.33             # eccentricity of 'per tc secosw sesinw logk'3rd planet
params['w3'] = np.pi/2.         # argument of periastron of the star's orbit for 3rd planet
params['k3'] = 18.3226            # velocity semi-amplitude for 3rd planet

params['per4'] = 2.82           # period of 4th planet
params['tc4'] = 1087.07         # time of inferior conjunction of 4th planet
params['e4'] = 0.09             # eccentricity of 'per tc secosw sesinw logk' 4th planet
params['w4'] = np.pi/2.         # argument of periastron of the star's orbit for 4th planet
params['k4'] = 14.3591           # velocity semi-amplitude for 4th planet

params['per5'] = 263.685712162  # period of 5th planet
params['tc5'] = 2000.07         # time of inferior conjunction of 5th planet
params['e5'] = 0.09             # eccentricity of 'per tc secosw sesinw logk' 5th planet
params['w5'] = np.pi/2.         # argument of periastron of the star's orbit for 5th planet
params['k5'] = 10.0             # velocity semi-amplitude for 3rd planet

params['dvdt'] = 0.0            # slope
params['curv'] = 0.0            # curvature

params['gamma_k'] = 0.0         # velocity zero-point for hires_rk
params['jit_k'] = 2.6           # jitter for hires_rk

params['gamma_j'] = 1.0         # "                   "   hires_rj
params['jit_j'] = 2.6           # "      "   hires_rj




# Load radial velocity data, in this example the data is contained in an hdf file,
# the resulting dataframe or must have 'time', 'mnvel', 'errvel', and 'tel' keys
data = pd.read_csv('C:/users/rscsa/Research/radvel-master/research/HD75732/HD75732.csv')
#data = rv[24:653] #rj data
data['time'] = data.jd
data['mnvel'] = data.mnvel
data['errvel'] = data.errvel
data['tel'] = data.tel



# Set parameters to be held constant (default is for all parameters to vary). Must be defined in the fitting basis
vary = dict(
    #dvdt =False,
    #curv =False,
    #jit_j =False,
    #per1 =False,
    #tc1 =False,
    #secosw1 =False,
    #sesinw1 = False,
    #e1=False,
    #w1=False,
    #k1=False
    
    #per2 = False,
    #tc2 = False,
    #secosw2 = False,
    #sesinw2 = False
)


# Define prior shapes and widths here.
priors = [
    radvel.prior.EccentricityPrior( nplanets ),           # Keeps eccentricity < 1
    radvel.prior.PositiveKPrior( nplanets ),             # Keeps K > 0
    radvel.prior.Gaussian('per1',params['per1'],.25*params['per1']),
    radvel.prior.Gaussian('per2',params['per2'],.25*params['per2']),
    radvel.prior.Gaussian('per3',params['per3'],.25*params['per3']),
    radvel.prior.Gaussian('per4',params['per4'],.25*params['per4']),
    radvel.prior.Gaussian('per5',params['per5'],.25*params['per5']),
    radvel.prior.HardBounds('jit_j', 0.0, 15.0),
    radvel.prior.HardBounds('jit_k', 0.0, 15.0)
]


time_base = np.mean([np.min(data.time), np.max(data.time)])   # abscissa for slope and curvature terms (should be near mid-point of time baseline)


# optional argument that can contain stellar mass and
# uncertainties. If not set, mstar will be set to nan.
# stellar = dict(mstar=1.12, mstar_err= 0.05)

# optional argument that can contain planet radii, used for computing densities
# planet = dict(
#     rp1=5.68, rp_err1=0.56,
#     rp2=7.82, rp_err2=0.72,
# )

