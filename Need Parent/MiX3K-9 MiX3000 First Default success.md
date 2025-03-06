## Mobile Device

![[Pasted image 20230119103310.png]]

## Events Template (Looks Good)

![[Pasted image 20230119103350.png]]

![[Pasted image 20230119103410.png]]

## Mobile Device Template (Device Setting fixes needed)

![[Pasted image 20230119103447.png]]

### Connected Lines (Looks Good)

![[Pasted image 20230119103510.png]]

### Device Settings (==Some fixes needed==)

#### The following issues, will confirm

- [x] TESTERS: <mark class="hltr-orange">Excluded</mark>: Ignition wired not present (Not in MiX3K device, In **MiX4K** device)
- [x] TESTERS: <mark class="hltr-red">Incorrect</mark>: Preferred firmware version not selected
	- ![[Pasted image 20230120102532.png]]
	- [x] A part of the problem is that the MiX3K has no prepopulated dropdown list as for the MiX4K
		- [x] I will have a look how the 4K gets populated and implement the same for the 3K
		- [x] The reason is the FW has not been loaded on DEV. Busy sorting this out with Zonika and FW
		- [x] The FW is now there, but not made available. I will now check if I leave it like this, if it get's made available, else I will need to do that in code.
		- [x] The one switch didn't have a case clause for MiX3K, I will now add in all the code
		- [x] ![[MiX3K-9 FW Manually Enabled.png]]
		- [x] Now to test it with FW in Library was made available
		- [x] ![[MiX3K-9 FW Not manually made available.png]]
	- There is code that gives a default firmware id for the 4K if nothing is found in the DC, I am now in the process of adding this for the 3K as well
		- [x] Find out from Justus how he got to the 4K Id of: 898465241488003029
- [x] TESTERS: <mark class="hltr-green">Extra</mark>: Base MiX 3xxx mobile device feature set visible (In **MiX3K** device, Not in MiX4K device)
- [x] TESTERS: <mark class="hltr-orange">Excluded</mark>: Required Company ID on driver plug (Not in MiX3K device, In **MiX4K** device)
- [x] <mark class="hltr-red">Incorrect</mark>: Send AVLs - Send AVL in trip if distance is more than... (thought it was an incorrect value), should be 3280,84. 
	- **FINE**: This is correct as per the screenshot it is 1000m which will lbe 3280.84 feet once converted. No need to do anything here.
- [x] TESTERS: <mark class="hltr-orange">Excluded</mark>: Magix section (Not in MiX3K device, In **MiX4K** device)
- [x] TESTERS: <mark class="hltr-orange">Excluded</mark>: Private mode plug (Not in MiX3K device, In **MiX4K** device)

- Great news, most of the settings that were previously incorrect are now correctly set.

![[Pasted image 20230119103521.png]]

## Default Config Group (Looks Good)

![[Pasted image 20230119103601.png]]
