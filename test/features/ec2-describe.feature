Story: Describe an EC2

	As a SysAdmin
	I want to know the DNS name of my EC2
	So that I can remotely login and install stuffs in it
	
Scenario: Describe EC2 with no argument - see all details
	Given i_have_an_aws_account
	And i_create_an_ec2
	When i_describe_the_ec2_instance
	Then i_should_see_its_details
	Finally i_delete_the_ec2
		
Scenario: Describe EC2 AMI ID
	Given i_have_an_aws_account	
	And i_create_an_ec2
	When i_describe_the_ec2_instance_ami
	Then i_should_see_its_ami_id
	Finally i_delete_the_ec2
 		
Scenario: Describe EC2 size
	Given i_have_an_aws_account
	And i_create_an_ec2
	When i_describe_the_ec2_instance_size
	Then i_should_see_its_size
	Finally i_delete_the_ec2
	
Scenario: Describe EC2 DNS Name
	Given i_have_an_aws_account
	And i_create_an_ec2
	When i_describe_the_ec2_instance_dns_name
	Then i_should_see_its_dns_name
	Finally i_delete_the_ec2
