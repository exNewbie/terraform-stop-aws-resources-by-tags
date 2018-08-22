import boto3

################################################################################

def parse_arn(arn):
    elements = arn.split(':', 5)
    result = {
        'arn': elements[0],
        'partition': elements[1],
        'service': elements[2],
        'region': elements[3],
        'account': elements[4],
        'resource': elements[5],
        'resource_type': None
    }
    if '/' in result['resource']:
        result['resource_type'], result['resource'] = result['resource'].split('/',1)
    elif ':' in result['resource']:
        result['resource_type'], result['resource'] = result['resource'].split(':',1)
    return result

################################################################################

def stop_ec2_instance(instance_id):
    ec2 = boto3.client('ec2')
    ec2.stop_instances(InstanceIds = [ instance_id ])
    print('Stopping EC2 instance: ' + instance_id)
    return

################################################################################

def stop_rds_instance(instance_identifier):
    rds = boto3.client('rds')
    
    response = rds.describe_db_instances(
        DBInstanceIdentifier=instance_identifier,
    )

    for instance in response['DBInstances']:
        if instance['DBInstanceStatus'] != 'stopped':
            rds.stop_db_instance(DBInstanceIdentifier=instance_identifier)
            print('Stopping RDS instance: ' + instance_identifier)
    return

################################################################################

def lambda_handler(event, context):
    tags = event['tags']

    # TODO implement
    client_tagging = boto3.client('resourcegroupstaggingapi')
    
    resources = client_tagging.get_resources(
        TagFilters=tags,
        ResourceTypeFilters=[
            'ec2:instance',
            'rds:db'
        ]
    )
    
    for resource in resources['ResourceTagMappingList']:
        resource_details = parse_arn(resource['ResourceARN'])

        if resource_details['resource_type'] == 'instance': ## EC2 instance
            stop_ec2_instance(resource_details['resource'])
        elif resource_details['resource_type'] == 'db': ## RDS
            stop_rds_instance(resource_details['resource'])

    return
