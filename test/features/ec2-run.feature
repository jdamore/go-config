Story: Remotely Run a Script

	As a SysAdmin
	I want to remotely run a script on an existing EC2
	So that I can install packages on it

Scenario: Happy Path - Install git
	Given i_have_an_aws_account
	And i_create_an_ec2
	When i_run_on_the_ec2 git
	Then git_should_be_installed_on_the_ec2