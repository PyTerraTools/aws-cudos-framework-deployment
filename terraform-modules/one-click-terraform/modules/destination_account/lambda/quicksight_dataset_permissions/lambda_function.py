import os
import boto3
from aws_lambda_powertools import Logger
from botocore.config import Config

account_id = os.environ['QUICKSIGHT_ACCOUNT_ID']

logger = Logger()
quicksight_client = boto3.client('quicksight', config=Config(connect_timeout=5, read_timeout=5))

def lambda_handler(event, context):
    """
    Entry point for the AWS Lambda function.
    """
    logger.info("Lambda handler started")
    try:
        update_quicksight_dataset_permissions()
    except Exception as e:
        logger.exception(f"Exception in lambda_handler: {e}")
    logger.info("Lambda handler finished")
    
def list_quicksight_data_sets():
    """
    Retrieve the list of data sets in the QuickSight account
    """
    try:
        logger.info(f"Retrieving the list of data sets in the QuickSight account")

        response = quicksight_client.list_data_sets(
            AwsAccountId=account_id,
        )

        quicksight_data_sets = [dataset['DataSetId'] for dataset in response['DataSetSummaries']]

    except Exception as general_error:
        logger.error(f"An unexpected error occurred: {general_error}", exc_info=True)
    return quicksight_data_sets

def list_quicksight_users():
    """
    Retrieve the list of QuickSight users
    """
    try:
        logger.info(f"Retrieving the list of users in the QuickSight account")

        response = quicksight_client.list_users(
            AwsAccountId=account_id,
            Namespace='default'
        )

        quicksight_user_list = [user['Arn'] for user in response["UserList"]]
            
    except Exception as general_error:
        logger.error(f"An unexpected error occurred: {general_error}", exc_info=True)
    return quicksight_user_list

def update_quicksight_dataset_permissions():
    """
    Update the permissions for the QuickSight data sets
    """
    try:
        logger.info(f"Updating the permissions for the Quicksight data sets")

        user_list = list_quicksight_users()
        dataset_list = list_quicksight_data_sets()

        for user in user_list:
            for dataset in dataset_list:
                response = quicksight_client.update_data_set_permissions(
                    AwsAccountId=account_id,
                    DataSetId=dataset,
                    GrantPermissions=[
                        {
                            'Principal': user,
                            'Actions': [
                                'quicksight:DescribeDataSet',
                                'quicksight:DescribeDataSetPermissions',
                                'quicksight:PassDataSet',
                                'quicksight:DescribeIngestion',
                                'quicksight:ListIngestions'
                            ]
                        },
                    ]
                )
                logger.info(f"Updated permissions for dataset {dataset} for user {user}: {response}")
    except Exception as general_error:
        logger.error(f"An unexpected error occurred: {general_error}", exc_info=True)