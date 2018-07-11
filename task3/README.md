Task details: Take backup of the instances using AWS Lambda. (Need to take image of the instances incremental). 
ec2-backup

This Lambda function performs snapshot backups of EC2 instances with custom retention schemes based on tags defined against those instances

Installation

IAM Policy Document

The Lambda function requires the following permissions:

•	ec2:DescribeInstances

•	ec2:DescribeVolumes

•	ec2:CreateSnapshot

•	ec2:DeleteSnapshot

•	ec2:DescribeSnapshots

•	ec2:CreateTags

These can be defined in IAM with the following policy document.
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:*"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Effect": "Allow",
            "Action": "ec2: Describe*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2: CreateSnapshot",
                "ec2: DeleteSnapshot",
                "ec2: CreateTags"
            "Resource": [
                "*"
            ]
        },
     
    ]
}
Configuration

At the top of the script, a there are a number of configuration directives:

•	regions (default: [region where Lambda function is running]) - list of regions to snapshot

•	retention_days (default: 2) - integer number of days to keep snapshots. This is overridden by specifying ‘ec2_backup_count' tag on the VM with an integer of the number of backups to retain.

 Configuring EC2 Instances for Backup
 
Each instance you wish to backup requires the following two tags:

•	ec2_backup_enabled: Must be set to true to enable backups to be taken.

•	ec2_backup_count: Specifies the number of daily backups to retain.


