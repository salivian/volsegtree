import sys
import scipy.misc
import numpy as np

def rescale01(array):
    return (array-np.min(array))/(np.max(array)-np.min(array))

def main():
    infilename = sys.argv[1]

    #parse the filename
    s = infilename.split('/');
    path = "/".join(s[0:-2])
    if path != "": path += "/"

    filename = s[-1].split('.')
    filename = ".".join(filename[0:-1])

    histfilename = path+"hist"+filename+".png"
    extent = sys.argv[2:2+3]
    extent = [int(i) for i in extent]
    extent = extent[::-1] #reverse order (matrix order)

    #read file and reshape
    img = np.fromfile(infilename,dtype=np.dtype('<u1'))
    img = img.astype('f')
    img = np.reshape(img, extent)
    img[np.nonzero(img>1e10)] = 0


    #compute gradient
    print 'gradient...'
    grad = np.gradient(img)
    gradmag = np.sqrt(grad[0]**2+grad[1]**2+grad[2]**2)
    np.seterr(divide='ignore')
    igradmag = 1.0/gradmag;
    igradmag[np.isnan(igradmag)]=0
    igradmag[np.isinf(igradmag)]=0
    grad[0]=np.multiply(grad[0],igradmag);
    grad[1]=np.multiply(grad[1],igradmag);
    grad[2]=np.multiply(grad[2],igradmag);

    #compute histogram
    print 'histogram...'
    [H, xedges, yedges] = np.histogram2d(img.ravel(),\
                                         gradmag.ravel(),\
                                         bins=128)
    H += 1;

    scipy.misc.imsave(histfilename,np.log(H.transpose()))
    
if __name__ == '__main__':
    main()
