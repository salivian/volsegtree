# Volume Segmentation Tree
The project produces a volume segment hierarchy from a raw volume data

## Prerequisites
  * Matlab ncut code
      http://timotheecour.com/software/ncut/ncut.html

  * Scipy/Numpy
      http://www.scipy.org/

## How to run?

```
python histogram.py <file.raw> <x> <y> <z>
```

`<file.raw>` is the raw volume cube, `x`, `y`, and `z` the are volume
dimensions.

This will produce an intensity-gradient histogram in `<file.png>`

```
RecursiveSeg(#seg, <file.png>)
```

`#seg` is the desired number of segments, `#seq` should be a power of
2 for constructing a full binary tree.  Run `RecursiveSeg` in matlab
on `<file.png>` will produce an image with labels as pixel values.
The parent-children relationship is encoded in the segment labels.  if
`childID > #nseg` (in the current level), `parentID = childID - #nseg/2`

The example directory contains the hierarchy image of vismale and tooth as used in the paper.

This software is made available for research and non-commercial use only.

### Citation

Hierarchical Exploration of Volumes Using Multilevel Segmentation of the Intensity Gradient Histograms <br />
C.Y. Ip, A. Varshney, and J. JaJa <br />
IEEE Transactions on Visualization and Computer Graphics, 18(12), 2012, pp 2355-2363.

```
@article{ip2012hierarchical,
  title={Hierarchical Exploration of Volumes Using Multilevel Segmentation of the Intensity-Gradient Histograms},
  author={Ip, C. Y. and Varshney, A. and JaJa, J.},
  journal={IEEE Transactions on Visualization and Computer Graphics},
  volume={18},
  number={12},
  pages={2355--2363},
  year={2012},
  publisher={IEEE}
}
```

https://youtu.be/Lyb97Po2_1g