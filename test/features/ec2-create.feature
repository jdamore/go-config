Story: Create an EC2

	As a SysAdmin
	I want to create an EC2 VM
	So that I can install stuffs on it
	
Scenario: Happy path - default values
	Given i_have_an_aws_account
	When i_create_an_ec2
	Then i_should_have_and_ec2_vm_on_aws
	Finally i_delete_the_ec2
