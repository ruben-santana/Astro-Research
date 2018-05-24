#Used for scientific computing
import numpy as np

#Needed to correct median with 'nan' data points
import math

#For making copies of data
import copy

#For Periodogram
from gatspy.periodic import LombScargleFast

#For Plotting
import matplotlib.pyplot as plt

#median
import statistics

###Removes nan data points
def remove_nan(datax,datay,yerr):
    #array of nan points location in flux array
    nan_points=np.array([])
    
    #finds points that have nan as data point
    for j in range(0,len(datax)-1):
        if math.isnan(datay[j])==True:
            nan_points = np.append(nan_points,j)
            
    #deletes the points with nan and correspoding time
    datax = np.delete(datax,nan_points)
    datay = np.delete(datay,nan_points)
    yerr = np.delete(yerr,nan_points)
        
    return(datax,datay,yerr)


#################### Median Smooth the flux of a star############################
#time - time data
#flux - flux data
#interval - number of data to smooth over for each step
def median_smooth(time,flux,interval,flux_err):    
    x = 0 #counter
    f_q = copy.copy(flux)
    #removing nan values
    t_q,f_q,fe_q= remove_nan(time,f_q,flux_err)
    f_sort=f_q[0:interval]
    f_ms =[]
    fe_ms =[]

    #gets first values not smoothed in interval
    #ex. interv = 5, gets first two points
    for i in range (0,(interval/2)):
        f_ms.append(f_q[i])
        fe_ms.append(fe_q[i])


    
#     while x+2< len(f_q)-3:
    while x+(interval/2)< len(f_q)-(interval/2):
        f_sort = np.sort(f_q[x:x+interval]) #sort data min to max
        f_median = statistics.median(f_sort) #find median
        
        #median smoothing flux error
        fe_sort = np.sort(fe_q[x:x+interval]) #sort data min to max
        fe_median = statistics.median(fe_sort) #find median
        
#         if f_q[2+x] > f_median:#only changes if median is greater than point being changed
#         f_q[2+x] = f_median #replace value with median
#         fe_q[2+x] = fe_median #replacing value with flux error

        f_ms.append(f_median)
        fe_ms.append(fe_median)


        x = x+1
    
    for i in range (-1*(interval/2), 0):
        f_ms.append(f_q[i])
        fe_ms.append(fe_q[i])

    return (t_q,f_ms,fe_ms)



#### DETRENDING FUNCTION##############
#This was used in my initial attempt to smooth data: gave correct period but wrong lightcurve depth and shape when folded.
def detrend(t_norm,f_norm,ferr_norm):
    
    
    #finding the running average interval(needs to be odd number)
    npts = int(len(f_norm))
    n = int(np.sqrt(npts))
    if int(np.sqrt(npts))%2 ==0:
         n=n+1
            
    #making copy to get running avg       
    c = copy.copy(f_norm)
    ce = copy.copy(ferr_norm)


    #Finding running avg vector
    for i in range(0,len(f_norm)-(n)+1):
        low_r = i #lower range
        high_r = low_r + n #upper range
        center = i + (n+1)/2 #center of interval
        data = f_normalized[low_r:high_r] #interval of data
        #running = np.mean(data,dtype=np.float64) #running average
        running = np.float64( "%f" % np.median(data)) #for running median

        c[center] = running #copying average to center of interval point

        
    #doesn't change the first (n+1)/2 and last (n+1)/2 points
    low_r = (n+1)/2 #first point changed 
    high_r = len(f_norm)-low_r #last point changed
    f_detrend = 1+(f_norm[low_r:high_r]- c[low_r:high_r])#final array has n less points
    t_detrend = t_norm[low_r:high_r]#corresponding time 
    ferr_detrend = ferr_norm[low_r:high_r]#corresponding time 

    
    return (t_detrend,f_detrend,ferr_detrend)


#### DETRENDING FUNCTION##############
def detrend2(time,flux,flux_err):
    
    x = 0 #counter
    f_q = copy.copy(flux)
    #removing nan values
    t_q,f_q,fe_q= remove_nan(time,f_q,flux_err)
    
    
    #finding the running average interval(needs to be odd number)
    npts = int(len(f_q))
    n = int(np.sqrt(npts))
    if int(np.sqrt(npts))%2 ==0:
         n=n+1
            
    #making copy to get running avg       
    c = copy.copy(f_q)
    ce = copy.copy(fe_q)
    

    #Finding running avg vector
    for i in range(0,len(f_q)-3):
        low_r = i #lower range
        high_r = low_r + n #upper range
        center = (high_r+low_r-1)/2 #center of interval fix this
        if high_r >= len(f_q):
            high_r = -1
            print 'high: ',high_r
            print i
            print center
        #center = i + (n+1)/2 #center of interval fix this

        data = f_q[low_r:high_r] #segment of data used for interval
        #running = np.mean(data,dtype=np.float64) #running average
        running = np.float64( "%f" % np.median(data)) #for running median

        c[center] = running #copying average to center of interval point

        
    #doesn't change the first (n+1)/2 and last (n+1)/2 points
    low_r = (n+1)/2 #first point changed 
    high_r = len(f_q)-low_r #last point changed
    f_detrend = np.array()
    f_detrend.append(f_q[0:low_r])
    f_detrend = (f_q[low_r:high_r]- c[low_r:high_r])#final array has n less points
    #t_detrend = t_q[low_r:high_r]#corresponding time 
    #ferr_detrend = fe_q[low_r:high_r]#corresponding time 
    f_detrend.append(f_q[high_r:-1])


    
    return (t_q,f_detrend,fe_q)

############# Detrending Part 3 #############
def detrend3(time,flux,flux_err):   
    
    x = 0 #counter
    f_q = copy.copy(flux)
    #removing nan values
    t_q,f_q,fe_q= remove_nan(time,f_q,flux_err)
    interval = int(np.sqrt(len(flux)))
    f_sort=f_q[0:interval]
    f_trend =[]
    fe_trend =[]

    #gets first values not smoothed in interval
    #ex. interv = 5, gets first two points
    for i in range (0,(interval/2)):
        f_trend.append(f_q[i])
        fe_trend.append(fe_q[i])


    
#     while x+2< len(f_q)-3:
    while x+(interval/2)< len(f_q)-(interval/2):
        f_sort = np.sort(f_q[x:x+interval]) #sort data min to max
        f_median = statistics.median(f_sort) #find median
        
        #median smoothing flux error
        fe_sort = np.sort(fe_q[x:x+interval]) #sort data min to max
        fe_median = statistics.median(fe_sort) #find median
        
#         if f_q[2+x] > f_median:#only changes if median is greater than point being changed
#         f_q[2+x] = f_median #replace value with median
#         fe_q[2+x] = fe_median #replacing value with flux error

        f_trend.append(f_median)
        fe_trend.append(fe_median)


        x = x+1
    
    for i in range (-1*(interval/2), 0):
        f_trend.append(f_q[i])
        fe_trend.append(fe_q[i])
        
    f_detrend = f_q - f_trend
    fe_detrend = fe_q - fe_trend
    
    return(t_q, f_detrend, fe_detrend)
    


def remove_above(datax,datay,yerr,cutoff):
    #array of nan points location in flux array
    cutoff_points=[]
    
    #finds points that are greater than cutoff point
    for i in range(0,len(datay)-1):
        if datay[i] > cutoff:
            cutoff_points.append(i)
    if len(cutoff_points) >= 1:    
        #deletes the points that are greater than cutoff
        datax = np.delete(datax,cutoff_points)
        datay = np.delete(datay,cutoff_points)
        yerr = np.delete(yerr,cutoff_points)

    
    print "removed", len(cutoff_points), "points."
    return(datax,datay,yerr)




###Lomb-Scargle Periodogram##############

# Used to find periodic activity of star 
### Works only if you remove "nan" data points
#datax - time data
#datay - flux data
#min_per - range minimum for finding period
#max_per -  range maximum for finding period
#nyquist -  time between data points
def periodogram(datax, datay, min_per, max_per, nyquist):
    #finding periodogram
    model = LombScargleFast().fit(datax, datay)
    period, power = model.periodogram_auto(nyquist_factor=nyquist)
    
    #plotting
    x_label = 'Period'
    y_label = 'Power'
    title = 'Lomb-Scargle Periodogram'
    
    plt.xlabel(x_label)
    plt.ylabel(y_label)
    plt.semilogx(period,power)

    # set range and find period
    model.optimizer.period_range=(min_per, max_per)
    period = model.best_period
    print("period = {0}".format(period))
    return period

#### Copying code from: https://ridlow.wordpress.com/category/ipython-notebook/

# t - time is an N-dimensional array of timestamps for the light curve,
# x - flux is the N-dimensional light curve array,
# qmi is the minimum transit duration to test, and
# qma is the maximum transit duration to test.
# fmin is the minimum frequency to test,
# df is the frequency grid spacing,
# nb is the number of bins to use in the folded light curve,
# nf is the number of frequency bins to test,

def func_bls(t, x, qmi, qma, fmin, df, nf, nb):
    """Frist trial, BLS algorithm, only minor modification from author's code"""
    
    n = len(t); rn = len(x)
    #! use try
    if n != rn:
        print "Different size of array, t and x"
        return 0

    rn = float(rn) # float of n

    minbin = 5
    nbmax = 2000
    if nb > nbmax:
        print "Error: NB > NBMAX!"
        return 0

    tot = t[-1] - t[0] # total time span

    if fmin < 1.0/tot:
        print "Error: fmin < 1/T"
        return 0

    # parameters in binning (after folding)
    kmi = int(qmi*nb) # nb is number of bin -> a single period
    if kmi < 1: 
        kmi = 1
    kma = int(qma*nb) + 1
    kkmi = rn*qmi # to check the bin size
    if kkmi < minbin: 
        kkmi = minbin

    # For the extension of arrays (edge effect: transit happen at the edge of data set)
    nb1 = nb + 1
    nbkma = nb + kma
        
    # Data centering
    t1 = t[0]
    u = t - t1
    s = np.mean(x) # ! Modified
    v = x - s

    bpow = 0.0
    p = np.zeros(nf)
    # Start period search
    for jf in range(nf):
        f0 = fmin + df*jf # iteration in frequency not period
        p0 = 1.0/f0

        # Compute folded time series with p0 period
        ibi = np.zeros(nbkma)
        y = np.zeros(nbkma)
        for i in range(n):
            ph = u[i]*f0 # instead of t mod P, he use t*f then calculate the phase (less computation)
            ph = ph - int(ph)
            j = int(nb*ph) # data to a bin 
            ibi[j] = ibi[j] + 1 # number of data in a bin
            y[j] = y[j] + v[i] # sum of light in a bin
        
        # Extend the arrays  ibi()  and  y() beyond nb by wrapping
        for j in range(nb1, nbkma):
            jnb = j - nb
            ibi[j] = ibi[jnb]
            y[j] = y[jnb]

        # Compute BLS statictics for this trial period
        power = 0.0

        for i in range(nb): # shift the test period
            s = 0.0
            k = 0
            kk = 0
            nb2 = i + kma
            # change the size of test period (from kmi to kma)
            for j in range(i, nb2): 
                k = k + 1
                kk = kk + ibi[j]
                s = s + y[j]
                if k < kmi: continue # only calculate SR for test period > kmi
                if kk < kkmi: continue # 
                rn1 = float(kk)
                powo = s*s/(rn1*(rn - rn1))
                if powo > power: # save maximum SR in a test period
                    power = powo # SR value
                    jn1 = i # 
                    jn2 = j
                    rn3 = rn1
                    s3 = s

        power = math.sqrt(power)
        p[jf] = power

        if power > bpow:
            bpow = power # Save the absolute maximum of SR
            in1 = jn1
            in2 = jn2
            qtran = rn3/rn
            # depth = -s3*rn/(rn3*(rn - rn3))
            # ! Modified
            high = -s3/(rn - rn3)
            low = s3/rn3
            depth = high - low
            bper = p0
    
    # ! add
    sde = (bpow - np.mean(p))/np.std(p) # signal detection efficiency

    return bpow, in1, in2, qtran, depth, bper, sde, p, high, low