### F2PY for the Protonated Water Potential from the Bowman group

This repository will allow you to run the protatnted water PES from the 
Bowman group very easily in Python through the use of 
[F2Py](https://docs.scipy.org/doc/numpy/f2py/). The first thing you will
need is all the source code for the potential which, if you don't have,
you will need to message me for either through email or Slack if you're
in the McCoy group.

Once you have the three folders of source code and that is put into the 
main directory of the repository we can start the process. First we will
compile everything using the bash script included in the repo called
"build.sh". This will compile all the needed libraries and make the .so
file that will be called from inside Python. Once everything is compiled
you will use the class within "ProtantedWaterPot.py" to utilize the PES.

To use this in a scipt you will want to do the following;
```python
from Prot_water_pot import Potential
Pot = Potential(natm) # where natm is the number of atoms in your system
```

This initializes the potential so that it can be used in further calls.
In order to get the potential for some geometries of these water clusters
you will do the following;
```python
V = Pot.get_potential(coords)
```
where coords is a 3-D array in the form (number of geometries, number of 
atoms, xyz) in Bohr. This will output an array with potentials for each 
geometry in Hartree.

If you have any questions, feel free to reach out to me over email or 
Slack. Have fun calculating energies!