# Example Keplerian fit configuration file
# Required packages for setup
import os
import pandas as pd
import numpy as np
import radvel
import os

# Define global planetary system and dataset parameters
starname = 'HD217014'
nplanets = 1    # number of planets in the system
instnames = ['j']    # list of instrument names. Can be whatever you like but should match 'tel' column in the input file.
ntels = len(instnames)       # number of instruments with unique velocity zero-points
fitting_basis = 'per tc secosw sesinw k'    # Fitting basis, see radvel.basis.BASIS_NAMES for available basis names
bjd0 = 2.44e6 + 3927.050417
planet_letters = {1: 'b'}

# Define prior centers (initial guesses) here.
params = radvel.RVParameters(nplanets,basis='per tc e w k')    # initialize RVparameters object

params['per1'] = 4.23078166873     # period of 1st planet
params['tc1'] = 2072.79438    # time of inferior conjunction of 1st planet
params['e1'] = 0.00          # eccentricity of 'per tc secosw sesinw logk'1st planet
params['w1'] = np.pi/2.      # argument of periastron of the star's orbit for 1st planet
params['k1'] =  35.7      # velocity semi-amplitude for 1st planet


params['dvdt'] = 0.0         # slope
params['curv'] = 0.0         # curvature

params['gamma_j'] = 1.0      # "                   "   hires_rj
params['jit_j'] = 2.6        # "      "   hires_rj


# Load radial velocity data, in this example the data is contained in an hdf file,
# the resulting dataframe or must have 'time', 'mnvel', 'errvel', and 'tel' keys
# path = os.path.join(radvel.DATADIR,'epic203771098.csv')
data = pd.read_csv('C:/users/rscsa/Research/radvel-master/HD217014/HD217014.csv')
data['time'] = data.time
data['mnvel'] = data.mnvel
data['errvel'] = data.errvel
data['tel'] = 'j'
# print data['time']


# Set parameters to be held constant (default is for all parameters to vary). Must be defined in the fitting basis
vary = dict(
    #dvdt =False,
    curv =False,
    #jit_j =False,
    #per1 =False,
    #tc1 =False,
    #secosw1 =False,
    #sesinw1 = False,
    #e1=False,
    #w1=False,
    #k1=False
    
#    per2 = False,
#     tc2 = False,
#     secosw2 = False,
#     sesinw2 = False
)


# Define prior shapes and widths here.
priors = [
    radvel.prior.EccentricityPrior( nplanets ),           # Keeps eccentricity < 1
    radvel.prior.PositiveKPrior( nplanets ),             # Keeps K > 0
    radvel.prior.Gaussian('tc1', params['tc1'], 300),    # Gaussian prior on tc1 with center at tc1 and width 0.01 days
    radvel.prior.Gaussian('per1', params['per1'], 1),
#     radvel.prior.Gaussian('tc2', params['tc2'], 0.01),
#     radvel.prior.Gaussian('per2', params['per2'], 0.01),
    radvel.prior.HardBounds('jit_j', 0.0, 15.0)
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

