# Example Keplerian fit configuration file

# Required packages for setup
import os
import pandas as pd
import numpy as np
import radvel

# Define global planetary system and dataset parameters
starname = 'KOI 265'
nplanets = 1    # number of planets in the system
instnames = ['j']    # list of instrument names. Can be whatever you like but should match 'tel' column in the input file.
ntels = len(instnames)       # number of instruments with unique velocity zero-points
fitting_basis = 'per tc secosw sesinw logk'    # Fitting basis, see radvel.basis.BASIS_NAMES for available basis names
bjd0 = 2440000  # reference epoch for RV timestamps (i.e. this number has been subtracted off your timestamps)
# planet_letters = {1: 'b', 2: 'c'}   # map the numbers in the RVParameters keys to planet letters (for plotting and tables)

# Define prior centers (initial guesses) here.
params = radvel.RVParameters(nplanets,basis='per tc e w k')    # initialize RVparameters object

params['per1'] = 3.56760613628      # period of 1st planet
params['tc1'] = 2440000+15783.     # time of inferior conjunction of 1st planet
params['e1'] = 0.01          # eccentricity of 1st planet
params['w1'] = np.pi/2.      # argument of periastron of the star's orbit for 1st planet
params['k1'] = 8          # velocity semi-amplitude for 1st planet
params['secosw1'] = 0.01 
params['sesinw1'] =  0.01 

# time_base = 2456778          # abscissa for slope and curvature terms (should be near mid-point of time baseline)
params['dvdt'] = 0.0         # slope: (If rv is m/s and time is days then [dvdt] is m/s/day)
params['curv'] = 0.0         # curvature: (If rv is m/s and time is days then [curv] is m/s/day^2)

params['gamma_j'] = 1.0      # "                   "   hires_rj
params['jit_j'] = 2.6        # "      "   hires_rj


# params['gamma_k'] = 0.0      # velocity zero-point for hires_rk
# params['gamma_j'] = 1.0      # "                   "   hires_rj
# params['gamma_a'] = 0.0      # "                   "   hires_apf

# params['jit_k'] = 2.6        # jitter for hires_rk
# params['jit_j'] = 2.6        # "      "   hires_rj
# params['jit_a'] = 2.6        # "      "   hires_apf


# Load radial velocity data, in this example the data is contained in an ASCII file, must have 'time', 'mnvel', 'errvel', and 'tel' keys
data = pd.read_csv('koi265_rvs.csv')
data['time'] = data.jd
data['mnvel'] = data.mnvel
data['errvel'] = data.errvel
data['tel'] = 'j'



# Set parameters to vary (False means "hold constant"; default is for all parameters to vary). 
#   Must be defined in the fitting basis
vary = dict(
    per1 = False
    # dvdt = False,
    # curv = False,
    # jit_k = True,
    # jit_j = True,
    # jit_a = True,
)


# Define prior shapes and widths here.
priors = [
    radvel.prior.EccentricityPrior( nplanets ),           # Keeps eccentricity < 1
    radvel.prior.Gaussian('tc1', params['tc1'], 360.0),    # Gaussian prior on tc1 with center at tc1 and width 300 days
    radvel.prior.Gaussian('secosw1',0,.5),
    radvel.prior.Gaussian('sesinw1',0,.5),
    # radvel.prior.HardBounds('jit_k', 0.0, 10.0),
    # radvel.prior.HardBounds('jit_j', 0.0, 10.0),
    # radvel.prior.HardBounds('jit_a', 0.0, 10.0)
]
time_base = np.mean([np.min(data.time), np.max(data.time)])

# optional argument that can contain stellar mass and
# uncertainties. If not set, mstar will be set to nan.
# stellar = dict(mstar=0.874, mstar_err=0.012)
