Story: Describe an EC2

	As a SysAdmin
	I want to know the DNS name of my EC2
	So that I can remotely login and install stuffs in it

	
Scenario: Happy path - no args - see all details
	Given i_have_an_aws_account
	And i_create_an_ec2
	When i_describe_the_ec2_instance
	Then i_should_see_its_details
	Finally i_delete_the_ec2
