Story: Remotely execute a script

	As a SysAdmin
	I want to remotely install a package on an existing VM
	So that I can remotely configure a VM
	
Scenario: Remotely install Git on an Unbuntu EC2 VM
	Given i_have_a_running_ec2_vm
	When i_install_on_the_ec2_the_module git
	Then the_module_should_be_installed_on_the_vm git
	Finally i_delete_the_ec2