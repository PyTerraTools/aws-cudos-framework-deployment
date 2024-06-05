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
        termination_protection()
    except Exception as e:
        logger.exception(f"Exception in lambda_handler: {e}")
    logger.info("Lambda handler finished")

def termination_protection():
    """ Disable termination protection setting so Terraform can destroy the QuickSight account """
    try:
        logger.info(f"Disabling termination protection for Amazon Quicksight")

        quicksight_client.update_account_settings(
            AwsAccountId=account_id,
            DefaultNamespace='default',
            TerminationProtectionEnabled=False
        )

    except Exception as general_error:
        logger.error(f"An unexpected error occurred: {general_error}", exc_info=True)
    return ([],)
