Story: Describe an EC2

	As a SysAdmin
	I want to know the DNS name of my EC2
	So that I can remotely login and install stuffs in it

	
Scenario: Happy path
	Given i_have_an_aws_account
	And i_create_an_ec2
	And i_wait 20 seconds
	When i_describe_the_ec2_instance
	Then i_should_see_its_dns_name
	Finally i_delete_the_ec2
