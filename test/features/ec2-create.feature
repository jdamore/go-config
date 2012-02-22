Story: Create an EC2

	As a SysAdmin
	I want to create an EC2 VM
	So that I can install stuffs on it
	
Scenario: Create an EC2 with default values
	Given i_have_an_aws_account
	When i_create_an_ec2
	Then i_should_have_an_ec2_vm_on_aws
	Finally i_delete_the_ec2
		
Scenario: Create an EC2 specifying the AMI and Size
	Given i_have_an_aws_account
	When i_create_an_ec2_with_ami_and_size ami-31814f58 c1.medium
	Then i_should_have_an_ec2_vm_on_aws
	And the_ec2_ami_should_be ami-31814f58
	And the_ec2_size_should_be c1.medium
	Finally i_delete_the_ec2
