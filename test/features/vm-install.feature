Story: Remotely execute a script

	As a SysAdmin
	I want to remotely install a package on an existing VM
	So that I can remotely configure a VM
	
Scenario: Remotely install Git on an Ubuntu EC2 VM
	Given i_have_a_running_ec2_vm
	And i_wait 10 seconds
	When i_install_on_the_ec2_the_module git
	Then the_module_should_be_installed_on_the_vm git
	